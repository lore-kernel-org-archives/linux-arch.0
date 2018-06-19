Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966597AbeFSQFC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 19 Jun 2018 12:05:02 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH -tip v6 01/27] Documentation/kprobes: Fix to remove remaining jprobe
Date: Wed, 20 Jun 2018 01:04:38 +0900
Message-ID: <152942427814.15209.6650206464370123166.stgit@devbox>
In-Reply-To: <152942424698.15209.15245996287444292393.stgit@devbox>
References: <152942424698.15209.15245996287444292393.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Message-ID: <20180619160438.B9P6KuNnTyokFc7FfhBbOucadXLGloLW8LUxZyFZzYg@z>

Remove jps from the document, since jprobe is removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/kprobes.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
index 22208bf2386d..5ae80baf3921 100644
--- a/Documentation/kprobes.txt
+++ b/Documentation/kprobes.txt
@@ -474,7 +474,7 @@ error occurs during registration, all probes in the array, up to
 the bad probe, are safely unregistered before the register_*probes
 function returns.
 
-- kps/rps/jps: an array of pointers to ``*probe`` data structures
+- kps/rps: an array of pointers to ``*probe`` data structures
 - num: the number of the array entries.
 
 .. note::
