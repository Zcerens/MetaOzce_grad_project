package com.example.hotel_gp.Service;

import com.example.hotel_gp.Entity.Hotel;
import com.example.hotel_gp.Entity.HotelUserHistory;
import com.example.hotel_gp.Entity.User;
import com.example.hotel_gp.Repository.HotelUserHistoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
@Service

public class HotelUserHistoryServiceImpl implements HotelUserHistoryService{
    @Autowired
    private HotelUserHistoryRepository hotelUserHistoryRepository;
    
    @Override //history e otel ekleme kontrolü & varsa hata mesajı ver yoksa ekle
    public List<HotelUserHistory> findAll() {
        return hotelUserHistoryRepository.findAll();
    }

    @Override
    public Optional<HotelUserHistory> findById(int id) {
        return hotelUserHistoryRepository.findById(id);
    }

    @Override
    public boolean isHotelAlreadyAdded(int userId, int hotelId) {
        List<HotelUserHistory> userHistory = findByUserId(userId);
        for (HotelUserHistory history : userHistory) {
            if (history.getHotel().getId() == hotelId) {
                return true;
            }
        }
        return false;

    }

    @Override//TODO create and update
    public Integer saveOrUpdate(HotelUserHistory hotelUserHistory) {
        Hotel hotel =hotelUserHistory.getHotel();
        User user =hotelUserHistory.getUser();

        boolean isHotelAlreadyAdded = isHotelAlreadyAdded(user.getId(), hotel.getId());

        if(isHotelAlreadyAdded){
            throw new RuntimeException("Hotel already added to user's history.");
        
        }
        return hotelUserHistoryRepository.save(hotelUserHistory).getId();
    }

    @Override
    //belirli oteli silme 
    public void deleteHotelFromHotelUserHistory(int userId, int hotelHistoryId) {
        
        Optional<HotelUserHistory> hotelUserHistoryOptional = hotelUserHistoryRepository.findById(hotelHistoryId);
        if (hotelUserHistoryOptional.isPresent()) {
            HotelUserHistory hotelUserHistory = hotelUserHistoryOptional.get();
            if (hotelUserHistory.getUser().getId() == userId) {
                hotelUserHistoryRepository.deleteById(hotelHistoryId);
            } else {
                throw new RuntimeException("Hotel does not belong to the user.");
            }
        } else {
            throw new RuntimeException("Hotel history not found.");
        }
    }


    @Override
    public void deleteById(int id) {
        hotelUserHistoryRepository.deleteById(id);

    }

    @Override
    public List<HotelUserHistory> findByUserId(int userId) {
        return hotelUserHistoryRepository.findByUser_Id(userId);
    }
}
