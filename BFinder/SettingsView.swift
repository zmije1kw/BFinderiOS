//
//  SettingsView.swift
//  BFinder
//
//  Created by Kevin Zmijewski on 8/10/25.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("BFinder™ Legal Terms & Privacy Policy")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 4)

                Text("Effective Date: August 1, 2025")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Group {
                    section("1. Eligibility",
                            "You must be at least 13 years of age to use this App. By using the App, you represent and warrant that you meet this requirement.")

                    section("2. Location Services",
                            "The App requires access to your device’s location services to function. By using the App, you consent to the collection, use, and processing of your precise and approximate location data to provide nearby breakfast and coffee location results and for other operational purposes, including analytics, performance improvement, and targeted advertising.")

                    section("3. Information We Collect",
                            """
                            a. Location Data: Required to provide core location-based services.
                            b. Device & Usage Data: Includes device model, OS version, crash logs, and usage patterns.
                            c. Cookies & Similar Technologies: May be used for personalization, analytics, and ads.
                            """)

                    section("4. How We Use Your Information",
                            """
                            - Provide and improve the App’s services
                            - Display relevant ads and promotions
                            - Conduct analytics and troubleshoot issues
                            - Develop new features and offerings
                            - Comply with legal requirements
                            """)

                    section("5. Sharing of Information",
                            """
                            We may share your information:
                            - With service providers for hosting, analytics, and ads
                            - If required by law or to protect our rights
                            - As part of a business transfer such as a merger or acquisition
                            - With advertisers for targeted ad delivery

                            We do not sell your personal information to third parties.
                            """)

                    section("6. Advertisements & Promotions",
                            "By using the App, you agree to receive advertisements, sponsored content, and promotional messages, which may be personalized based on your location and usage.")

                    section("7. Improvements & Updates",
                            "We may update or change the App without notice, including adding or removing features. Your continued use after updates constitutes acceptance of the changes.")

                    section("8. Fees & Future Costs",
                            "The App is currently free, but we reserve the right to introduce fees or subscriptions in the future. You will be notified before any charges are applied.")

                    section("9. User Conduct",
                            "You agree not to use the App for unlawful purposes, disrupt its operation, or attempt unauthorized access to our systems.")

                    section("10. Data Retention",
                            "We retain your information only as long as necessary for the purposes described in this policy, unless longer retention is required by law.")

                    section("11. Security",
                            "We implement reasonable safeguards to protect your information, but no method of transmission or storage is completely secure.")

                    section("12. Children’s Privacy",
                            "This App is not intended for children under 13, and we do not knowingly collect personal data from them.")

                    section("13. Disclaimers",
                            "The App is provided “as is” and “as available” without warranties of any kind. We do not guarantee the accuracy, completeness, or availability of any information provided.")

                    section("14. Limitation of Liability",
                            "To the fullest extent permitted by law, we are not liable for any indirect, incidental, special, or consequential damages arising from use of the App.")

                    section("15. Changes to These Terms",
                            "We may revise these Terms & Conditions and Privacy Policy at any time. The updated version will be posted within the App with a new “Effective Date.” Continued use of the App constitutes acceptance of the updated terms.")

                    section("16. Governing Law",
                            "These Terms are governed by the laws of the United States of America, without regard to its conflict of laws principles.")

                    section("17. Contact Us",
                            """
                            Kevin Zmijewski
                            zmije1kw@gmail.com
                            """)
                }
            }
            .padding()
        }
        .navigationTitle("Legal")
    }

    private func section(_ title: String, _ body: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            Text(body)
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    SettingsView()
}
