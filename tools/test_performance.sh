# Performance Testing

# Get Translation started (awake from slumber)
time ~/mt_web/cgi-bin/translate.py en zh "We specialize in speech technologies."

################################################################################
echo English > Chinese 
# Word by word translation
time ~/mt_web/cgi-bin/translate.py en zh "We"
time ~/mt_web/cgi-bin/translate.py en zh "specialize"
time ~/mt_web/cgi-bin/translate.py en zh "in"
time ~/mt_web/cgi-bin/translate.py en zh "speech"
time ~/mt_web/cgi-bin/translate.py en zh "technologies"

# Phrase Translation
time ~/mt_web/cgi-bin/translate.py en zh "We specialize in speech technologies."
time ~/mt_web/cgi-bin/translate.py en zh "We specialize in speech technologies."
time ~/mt_web/cgi-bin/translate.py en zh "We specialize in speech technologies."
time ~/mt_web/cgi-bin/translate.py en zh "We specialize in speech technologies."
time ~/mt_web/cgi-bin/translate.py en zh "We specialize in speech technologies."
time ~/mt_web/cgi-bin/translate.py en zh "We specialize in speech technologies."
time ~/mt_web/cgi-bin/translate.py en zh "We specialize in speech technologies."
time ~/mt_web/cgi-bin/translate.py en zh "We specialize in speech technologies."
time ~/mt_web/cgi-bin/translate.py en zh "We specialize in speech technologies."

# ################################################################################
# echo English > French 
# Word by word translation
time ~/mt_web/cgi-bin/translate.py en fr "We"
time ~/mt_web/cgi-bin/translate.py en fr "specialize"
time ~/mt_web/cgi-bin/translate.py en fr "in"
time ~/mt_web/cgi-bin/translate.py en fr "speech"
time ~/mt_web/cgi-bin/translate.py en fr "technologies"

# # Phrase Translation
time ~/mt_web/cgi-bin/translate.py en fr "We specialize in speech technologies."
time ~/mt_web/cgi-bin/translate.py en fr "We specialize in speech technologies."
time ~/mt_web/cgi-bin/translate.py en fr "We specialize in speech technologies."
time ~/mt_web/cgi-bin/translate.py en fr "We specialize in speech technologies."
time ~/mt_web/cgi-bin/translate.py en fr "We specialize in speech technologies."
time ~/mt_web/cgi-bin/translate.py en fr "We specialize in speech technologies."
time ~/mt_web/cgi-bin/translate.py en fr "We specialize in speech technologies."
time ~/mt_web/cgi-bin/translate.py en fr "We specialize in speech technologies."
time ~/mt_web/cgi-bin/translate.py en fr "We specialize in speech technologies."

