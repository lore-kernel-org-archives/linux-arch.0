Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55943 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752666AbeDCQ4e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Apr 2018 12:56:34 -0400
Received: by mail-wm0-f66.google.com with SMTP id b127so34308517wmf.5
        for <linux-arch@vger.kernel.org>; Tue, 03 Apr 2018 09:56:34 -0700 (PDT)
From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [PATCH 1/3] Documentation/features: Add script that refreshes the arch support status files in place
Date: Tue,  3 Apr 2018 18:55:49 +0200
Message-ID: <1522774551-9503-2-git-send-email-andrea.parri@amarulasolutions.com>
In-Reply-To: <1522774551-9503-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1522774551-9503-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, Andrea Parri <andrea.parri@amarulasolutions.com>
Message-ID: <20180403165549.HjqmKa5f-NjROEL_RXk1fzAezHvU9vJ5JrYuLUFFfAE@z>

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 Documentation/features/scripts/features-refresh.sh | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100755 Documentation/features/scripts/features-refresh.sh

diff --git a/Documentation/features/scripts/features-refresh.sh b/Documentation/features/scripts/features-refresh.sh
new file mode 100755
index 0000000000000..ae3e9d5d3f262
--- /dev/null
+++ b/Documentation/features/scripts/features-refresh.sh
@@ -0,0 +1,55 @@
+#
+# Small script that refreshes the kernel feature support status in place.
+#
+
+for F_FILE in Documentation/features/*/*/arch-support.txt; do
+	K=$(grep "^#         Kconfig:" "$F_FILE" | cut -c26-)
+	K_VALID="false" # K is 'valid' iff there exists a Kconfig file
+			# (for some arch) containing K.
+
+	for ARCH_DIR in arch/*/; do
+		K_FILES=$(find $ARCH_DIR -name "Kconfig*")
+
+		K_GREP=$(grep "$K" $K_FILES)
+		if [ ! -z "$K_GREP" ]; then
+			K_VALID="true"
+			break
+		fi
+	done
+
+	if [ "$K_VALID" = "false" ]; then
+		printf "WARNING: '%s' is not a valid Kconfig\n" "$K"
+	fi
+
+	T_FILE="$F_FILE.tmp"
+
+	grep "^#" $F_FILE > $T_FILE
+	echo "    -----------------------" >> $T_FILE
+	echo "    |         arch |status|" >> $T_FILE
+	echo "    -----------------------" >> $T_FILE
+
+	for ARCH_DIR in arch/*/; do
+		ARCH=$(echo $ARCH_DIR | sed -e 's/arch//g' | sed -e 's/\///g')
+		K_FILES=$(find $ARCH_DIR -name "Kconfig*")
+
+		K_GREP=$(grep "$K" $K_FILES)
+		if [ ! -z "$K_GREP" ]; then
+			# K is 'supported by a given arch', if there exists
+			# a Kconfig file for this arch containing K.
+			printf "    |%12s: |  ok  |\n" "$ARCH" >> $T_FILE
+		else
+			# ... Otherwise: Keep the original status (if any);
+			# default to "not yet supported".
+			S=$(grep -v "^#" "$F_FILE" | grep " $ARCH:")
+			if [ ! -z "$S" ]; then
+				echo "$S" >> $T_FILE
+			else
+				printf "    |%12s: | TODO |\n" "$ARCH" \
+					>> $T_FILE
+			fi
+		fi
+	done
+
+	echo "    -----------------------" >> $T_FILE
+	mv $T_FILE $F_FILE
+done
-- 
2.7.4
