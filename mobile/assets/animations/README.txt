Drop free Lottie JSON files here using these exact filenames so they auto-bind
to SupernovaAnimations:

  streak_fire.json   — looped flame for streak hub
  success_burst.json — 1-shot burst on quiz pass
  try_again.json     — gentle wobble for incorrect/result review
  ai_orb.json        — looped orb for AI Tutor entry
  empty_inbox.json   — empty state for notifications
  search_spark.json  — empty state for search
  trophy.json        — quiz result hero
  confetti.json      — quiz result celebration overlay

Free sources:
  • https://lottiefiles.com/free-animations
  • https://iconscout.com/lotties

Files are loaded with a 30fps cap (SupernovaLottie) to keep frame budget low.
If a file is missing, the app silently falls back to a pure-Dart PulseRing —
no crash, no blank UI. So you can ship the prototype without bundling all of
them, and the design system still feels alive.
