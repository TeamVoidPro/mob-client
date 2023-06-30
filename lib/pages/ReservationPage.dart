import 'package:flutter/material.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPage();
}

class _ReservationPage extends State<ReservationPage> with SingleTickerProviderStateMixin{
  late TabController _tabController ;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this,initialIndex: 0); // Replace '3' with the number of tabs you want
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pushNamed(context, '/book/payment');
          },
          icon: Icon(Icons.keyboard_arrow_left),
        ),
        title: Text( _tabController.index == 0 ? 'My Reservation' : 'My Booking'
        , style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        bottom: TabBar(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          controller: _tabController,
          dividerColor: Colors.transparent,
          indicatorColor: Colors.transparent,
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.tab,
          onTap: (index) {
            setState(() {
              _tabController.index = index;
            });
          } ,

          tabs: [
            Tab(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                  color: _tabController.index == 0 ? Color.fromARGB(255,  49, 111, 254) : Color.fromARGB(255, 217,217,217), // blue color
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('Reservation', style: TextStyle(color: _tabController.index ==0 ? Colors.white : Colors.black ,fontSize: 18),),
              ),
            ),
            Tab(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                  color: _tabController.index == 1 ? Color.fromARGB(255,  49, 111, 254) : Color.fromARGB(255, 217,217,217),// gray color
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('Bookings', style: TextStyle(color:  _tabController.index ==1 ? Colors.white : Colors.black,fontSize: 18,),textAlign: TextAlign.center,),
              ),
            ),

          ],

        ),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, '/chat');
            },
            icon: Icon(Icons.notifications_none_outlined, color: Colors.black,),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ReservationTab(),
          BookingTab(),
        ],
      ),
    );
  }
}

class ReservationTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255,  237, 249, 252),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
        ),
        child: Column(
          children: [
            for(int i=0; i<10; i++)
              Container(
                  margin: EdgeInsets.only(top: 20,left: 10,right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                  ),
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 34, 43, 69),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Image(image: AssetImage('assets/Images/ucsc.png'),width: 40,height: 40,),
                                  ),
                                  SizedBox(width: 20,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('UCSC Car Park ',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                                      Text(' Colombo 07',style: TextStyle(color: Colors.white,fontSize: 16),),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Time : ',style: TextStyle(color: Colors.white,fontSize: 16),textAlign: TextAlign.start,),
                                      Text('10.00 AM - 12.00 PM',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Reference ID : ',style: TextStyle(color: Colors.white,fontSize: 16),textAlign: TextAlign.start,),
                                      Text('RFC - ABC3245',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Price : ',style: TextStyle(color: Colors.white,fontSize: 16),textAlign: TextAlign.start,),
                                      Text('LKR 400.00',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )
                      ),
                      SizedBox(width: 5,),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.22,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center ,
                          children: [
                            Text('23',style: TextStyle(color: Color.fromARGB(255, 34, 43, 69),fontSize: 48,fontWeight: FontWeight.bold),),
                            SizedBox(height: 5),
                            Text('JUNE',style: TextStyle(color: Color.fromARGB(255, 34, 43, 69),fontSize: 20,fontWeight: FontWeight.bold),),
                            Text('2023',style: TextStyle(color: Color.fromARGB(255, 34, 43, 69),fontSize: 20,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ],
                  )
              ),

          ],
        ),
      ),
    );
  }
}

class BookingTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Search Tab Content'),
    );
  }
}