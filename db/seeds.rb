# User(id: integer, username: string, password_digest: string, email: string)
User.create(username: "Bruno", password: "1&Password", email: "brunogarciagonzalez@outlook.com")
User.create(username: "German", password: "2&Password", email: "germanjii@gmail.com")
# Link(id: integer, url: string)
Link.create(url: "https://www.x-cannabis.com")
Link.create(url: "https://www.google.com")
Link.create(url: "https://www.bing.com")
# Tag(id: integer, title: string)
Tag.create(title:"Cannabis")
Tag.create(title:"Social Media")
Tag.create(title: "Features")
Tag.create(title: "Finance")
Tag.create(title: "Shopping")
Tag.create(title: "Jobs")
Tag.create(title: "Internet")
Tag.create(title: "Software")
Tag.create(title: "Programming")
Tag.create(title: "Computer Games")
Tag.create(title: "Console Games")
Tag.create(title: "Board Games")
Tag.create(title: "News")
Tag.create(title: "TV")
Tag.create(title: "Radio")
Tag.create(title: "Entertainment")
Tag.create(title: "Music")
Tag.create(title: "Movies")
Tag.create(title: "Recreational")
Tag.create(title: "Sports")
Tag.create(title: "Travel")
Tag.create(title: "Autos")
Tag.create(title: "Motorcycles")
Tag.create(title: "Outdoors")
Tag.create(title: "Health")
Tag.create(title: "Diseases")
Tag.create(title: "Drugs")
Tag.create(title: "Fitness")
Tag.create(title: "Government")
Tag.create(title: "Countries")
Tag.create(title: "People")
Tag.create(title: "Environment")
Tag.create(title: "Religion")
Tag.create(title: "College & University")
Tag.create(title: "Education: K - 12")
Tag.create(title: "Photography")
Tag.create(title: "History")
Tag.create(title: "Literature")
Tag.create(title: "Animals")
Tag.create(title: "Astronomy")
Tag.create(title: "Engineering")
Tag.create(title: "Languages")
Tag.create(title: "Archaeology")
Tag.create(title: "Psychology")
Tag.create(title: "Dictionaries")
# LinkTagJoin(id: integer, link_id: integer, tag_id: integer)
LinkTagJoin.create(link_id: 1, tag_id: 1)
# TagComment(id: integer, tag_id: integer, tag_commenter_id: integer, content: text)
TagComment.create(tag_id: 1, tag_commenter_id: 2, content: "dope")
TagComment.create(tag_id: 1, tag_commenter_id: 1, content: "ganja")
# Review(id: integer, user_share_id: integer, reviewer_id: integer, link_id: integer, content: text, rating: integer)
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 1, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 8)
# ReviewComment(id: integer, review_id: integer, review_commenter_id: integer, content: text)
ReviewComment.create(review_id: 1, review_commenter_id: 2, content: "Nice review.")
# UserShare(id: integer, user_id: integer, review_id: integer, link_id: integer)
UserShare.create(user_id: 1, review_id: 1, link_id: 1)
UserShare.create(user_id: 1, review_id: 2, link_id: 1)
UserShare.create(user_id: 1, review_id: 3, link_id: 1)
UserShare.create(user_id: 1, review_id: 4, link_id: 1)
UserShare.create(user_id: 1, review_id: 5, link_id: 1)
UserShare.create(user_id: 1, review_id: 6, link_id: 1)
UserShare.create(user_id: 1, review_id: 7, link_id: 1)
UserShare.create(user_id: 1, review_id: 8, link_id: 1)
UserShare.create(user_id: 1, review_id: 9, link_id: 1)
UserShare.create(user_id: 1, review_id: 10, link_id: 1)
UserShare.create(user_id: 1, review_id: 11, link_id: 1)
UserShare.create(user_id: 1, review_id: 12, link_id: 1)
UserShare.create(user_id: 1, review_id: 13, link_id: 1)
UserShare.create(user_id: 1, review_id: 14, link_id: 1)
UserShare.create(user_id: 1, review_id: 15, link_id: 1)
UserShare.create(user_id: 1, review_id: 16, link_id: 1)
UserShare.create(user_id: 1, review_id: 17, link_id: 2)
UserShare.create(user_id: 1, review_id: 18, link_id: 2)
UserShare.create(user_id: 1, review_id: 19, link_id: 2)
UserShare.create(user_id: 1, review_id: 20, link_id: 2)
UserShare.create(user_id: 1, review_id: 21, link_id: 2)
UserShare.create(user_id: 1, review_id: 22, link_id: 2)
UserShare.create(user_id: 1, review_id: 23, link_id: 2)
UserShare.create(user_id: 1, review_id: 24, link_id: 2)
UserShare.create(user_id: 1, review_id: 25, link_id: 2)
UserShare.create(user_id: 1, review_id: 26, link_id: 2)
UserShare.create(user_id: 1, review_id: 27, link_id: 2)
UserShare.create(user_id: 1, review_id: 28, link_id: 2)
UserShare.create(user_id: 1, review_id: 29, link_id: 2)
UserShare.create(user_id: 1, review_id: 30, link_id: 2)
# UserShareTagJoin(id: integer, user_share_id: integer, tag_id: integer)
UserShareTagJoin.create(user_share_id: 1, tag_id: 7)
UserShareTagJoin.create(user_share_id: 2, tag_id: 7)
UserShareTagJoin.create(user_share_id: 3, tag_id: 7)
UserShareTagJoin.create(user_share_id: 4, tag_id: 7)
UserShareTagJoin.create(user_share_id: 5, tag_id: 7)
UserShareTagJoin.create(user_share_id: 6, tag_id: 7)
UserShareTagJoin.create(user_share_id: 7, tag_id: 7)
UserShareTagJoin.create(user_share_id: 11, tag_id: 7)
UserShareTagJoin.create(user_share_id: 12, tag_id: 7)
UserShareTagJoin.create(user_share_id: 13, tag_id: 7)
UserShareTagJoin.create(user_share_id: 14, tag_id: 7)
UserShareTagJoin.create(user_share_id: 15, tag_id: 7)
UserShareTagJoin.create(user_share_id: 16, tag_id: 7)
UserShareTagJoin.create(user_share_id: 17, tag_id: 7)
UserShareTagJoin.create(user_share_id: 18, tag_id: 7)
UserShareTagJoin.create(user_share_id: 19, tag_id: 7)
UserShareTagJoin.create(user_share_id: 21, tag_id: 7)
UserShareTagJoin.create(user_share_id: 22, tag_id: 8)
UserShareTagJoin.create(user_share_id: 11, tag_id: 8)
UserShareTagJoin.create(user_share_id: 12, tag_id: 8)
UserShareTagJoin.create(user_share_id: 13, tag_id: 8)
UserShareTagJoin.create(user_share_id: 13, tag_id: 8)
UserShareTagJoin.create(user_share_id: 14, tag_id: 8)
UserShareTagJoin.create(user_share_id: 15, tag_id: 8)
UserShareTagJoin.create(user_share_id: 15, tag_id: 8)
UserShareTagJoin.create(user_share_id: 18, tag_id: 8)
UserShareTagJoin.create(user_share_id: 19, tag_id: 8)
UserShareTagJoin.create(user_share_id: 10, tag_id: 8)
UserShareTagJoin.create(user_share_id: 25, tag_id: 8)
UserShareTagJoin.create(user_share_id: 22, tag_id: 8)



# need many reviews for at least three links
# need these links connected to a single tag
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 1, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 8)
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 1, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 2)
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 1, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 5)
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 1, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 9)
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 1, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 8)
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 1, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 2)
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 1, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 5)
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 1, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 9)
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 1, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 8)
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 1, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 5)
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 1, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 5)
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 1, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 9)
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 1, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 1)
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 1, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 2)
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 1, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 5)
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 1, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 9)

Review.create(user_share_id: 1, reviewer_id: 1, link_id: 2, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 3)
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 2, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 5)
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 2, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 7)
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 2, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 9)
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 2, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 4)
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 2, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 1)
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 2, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 3)
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 2, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 10)
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 2, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 8)
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 2, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 5)
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 2, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 5)
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 2, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 3)
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 2, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 3)
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 2, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 2)
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 2, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 5)
Review.create(user_share_id: 1, reviewer_id: 1, link_id: 2, content: "I have been a member of this social network since its first days (roughly). It has upgraded much and with a more active community I look forward to where it goes. I will keep checking in as it grows and will update my review. I think it is a nice niche of a social network.", rating: 9)

LinkTagJoin.create(link_id: 1, tag_id: 7)
LinkTagJoin.create(link_id: 2, tag_id: 7)
