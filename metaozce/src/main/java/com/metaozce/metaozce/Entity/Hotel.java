package com.metaozce.metaozce.Entity;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "Hotel")
public class Hotel {
  /*  public Hotel(Integer id, String name,String currency ) {
        this.id = id;
        this.name = name;
        this.currency=currency;
    }*/
    @Id
    //   @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;
    @Column(name = "name")
    private String name;
    @Column(name = "currency")
    private String currency;
    @Column(name = "unit_price")
    private Integer unitPrice;
    @Column(name = "unit_sale_price")
    private Integer unitSalePrice;

    @Column(name = "url")
    private String url;
    @Column(name = "product_image_url")
    private String productImageUrl;
}
