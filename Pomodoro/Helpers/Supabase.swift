//
//  Helper.swift
//  Pomodoro
//
//  Created by Shuyu Zhou on 2024-06-06.
//

import Foundation
import Supabase

let supabase = SupabaseClient(
  supabaseURL: URL(string: "https://rgfsksbxsztjubpbosud.supabase.co")!,
  supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJnZnNrc2J4c3p0anVicGJvc3VkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTc2MDI4MzMsImV4cCI6MjAzMzE3ODgzM30.Ye3EBjSIXT3odv0ihth45VqUzV9yw_Yk0w0aKDPXznU"
)
