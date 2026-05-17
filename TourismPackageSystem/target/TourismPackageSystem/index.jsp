<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>LankaTrail</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="nav.jsp"/>
    
    <!-- Hero Section -->
    <div class="hero-booking gsap-hero">
        <div class="container">
            <h1 class="gsap-item">Find your next stay in Sri Lanka</h1>
            <p class="lead mb-4 gsap-item">Search deals on customized travel packages, hotels, and activities...</p>
        </div>
    </div>

    <!-- The Yellow Overlapping Search Box -->
    <div class="container position-relative gsap-item" style="z-index: 10;">
        <div class="booking-search-bar">
            <form action="packages.jsp" method="get" class="inner-form m-0 row g-1">
                <div class="col-md-4">
                    <div class="input-group h-100">
                        <span class="input-group-text"><i class="bi bi-geo-alt-fill fs-5 text-secondary"></i></span>
                        <input type="text" name="q" class="form-control" placeholder="Where are you going?" required>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="input-group h-100">
                        <span class="input-group-text"><i class="bi bi-calendar-check fs-5 text-secondary"></i></span>
                        <input type="text" class="form-control" placeholder="Travel Dates (Anytime)">
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="input-group h-100">
                        <span class="input-group-text"><i class="bi bi-person-fill fs-5 text-secondary"></i></span>
                        <input type="number" name="persons" class="form-control" placeholder="2 adults · 1 room" min="1">
                    </div>
                </div>
                <div class="col-md-2">
                    <button type="submit" class="booking-btn w-100 h-100">Search</button>
                </div>
            </form>
        </div>
    </div>
    
    <!-- Explore Destinations Section -->
    <div class="container mt-5 pt-4 mb-5">
        <h3 class="section-title fw-bold mb-4">Trending destinations</h3>
        <p class="text-muted mb-4">Most popular choices for travelers visiting Sri Lanka</p>
        
        <div class="row g-3 gsap-stagger-container">
            <div class="col-md-6">
                <div class="dest-card gsap-stagger-item" onclick="window.location.href='packages.jsp?q=Ella'">
                    <img src="images/ella.png" alt="Ella">
                    <div class="overlay">
                        <h3>Ella</h3>
                        <p>Mountain views & hiking trails</p>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="dest-card gsap-stagger-item" onclick="window.location.href='packages.jsp?q=Galle'">
                    <img src="images/galle.png" alt="Galle">
                    <div class="overlay">
                        <h3>Galle</h3>
                        <p>Historic forts & beautiful beaches</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mt-3">
                <div class="dest-card gsap-stagger-item" onclick="window.location.href='packages.jsp?q=Kandy'">
                    <img src="images/kandy.png" alt="Kandy">
                    <div class="overlay">
                        <h3>Kandy</h3>
                        <p>Cultural heart of the island</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mt-3">
                <div class="dest-card gsap-stagger-item" onclick="window.location.href='packages.jsp?q=Mirissa'">
                    <img src="images/mirissa.png" alt="Mirissa">
                    <div class="overlay">
                        <h3>Mirissa</h3>
                        <p>Whale watching & nightlife</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mt-3">
                <div class="dest-card gsap-stagger-item" onclick="window.location.href='packages.jsp?q=Sigiriya'">
                    <img src="images/sigiriya.png" alt="Sigiriya">
                    <div class="overlay">
                        <h3>Sigiriya</h3>
                        <p>Ancient rock fortress</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- GSAP Scripts -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/ScrollTrigger.min.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", (event) => {
            gsap.registerPlugin(ScrollTrigger);

            // Hero Section Animation
            const tl = gsap.timeline();
            tl.from(".gsap-hero", {
                duration: 0.8,
                opacity: 0,
                ease: "power2.out"
            })
            .from(".gsap-item", {
                duration: 0.8,
                y: 30,
                opacity: 0,
                stagger: 0.15,
                ease: "power2.out"
            }, "-=0.3");

            // Scroll Animation for Destination Cards
            gsap.from(".gsap-stagger-item", {
                scrollTrigger: {
                    trigger: ".gsap-stagger-container",
                    start: "top 85%",
                    toggleActions: "play none none reverse"
                },
                duration: 0.6,
                scale: 0.9,
                opacity: 0,
                stagger: 0.1,
                ease: "back.out(1.2)"
            });
        });
    </script>
</body>
</html>
