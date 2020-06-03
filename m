From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC][PATCH 05/14] ia64: csum_partial_copy_nocheck(): don't
 abuse csum_partial_copy_from_user()
Date: Wed, 3 Jun 2020 20:10:38 +0100
Message-ID: <20200603191038.GV23230@ZenIV.linux.org.uk>
References: <20200327233006.GW23230@ZenIV.linux.org.uk>
 <20200327233117.1031393-1-viro@ZenIV.linux.org.uk>
 <20200327233117.1031393-5-viro@ZenIV.linux.org.uk>
 <20200603153714.GA33147@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFCTKr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jun 2020 15:10:47 -0400
Content-Disposition: inline
In-Reply-To: <20200603153714.GA33147@roeck-us.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 08:37:14AM -0700, Guenter Roeck wrote:
> On Fri, Mar 27, 2020 at 11:31:08PM +0000, Al Viro wrote:
> > From: Al Viro <viro@zeniv.linux.org.uk>
> > 
> > Just inline the call and use memcpy() instead of __copy_from_user() and
> > note that the tail is precisely ia64 csum_partial().
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> This patch results in:
> 
> arch/ia64/lib/csum_partial_copy.c: In function 'csum_partial_copy_nocheck':
> arch/ia64/lib/csum_partial_copy.c:110:9: error: implicit declaration of function 'csum_partial'
> 
> for ia64:{defconfig, allnoconfig, tinyconfig}.

Argh...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/arch/ia64/lib/csum_partial_copy.c b/arch/ia64/lib/csum_partial_copy.c
index 5d147a33d648..6e82e0be8040 100644
--- a/arch/ia64/lib/csum_partial_copy.c
+++ b/arch/ia64/lib/csum_partial_copy.c
@@ -12,7 +12,7 @@
 #include <linux/types.h>
 #include <linux/string.h>
 
-#include <linux/uaccess.h>
+#include <net/checksum.h>
 
 /*
  * XXX Fixme: those 2 inlines are meant for debugging and will go away
