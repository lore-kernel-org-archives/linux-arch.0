Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0058.hostedemail.com ([216.40.44.58]:36546 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725951AbfJJX4k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Oct 2019 19:56:40 -0400
Message-ID: <2231d5f0a82f880e6706e2d0f070328a029c9b21.camel@perches.com>
Subject: Re: [PATCH v2 3/4] treewide: Use sizeof_member() macro
From: Joe Perches <joe@perches.com>
Date: Thu, 10 Oct 2019 16:50:27 -0700
In-Reply-To: <20191010232345.26594-4-keescook@chromium.org>
References: <20191010232345.26594-1-keescook@chromium.org>
         <20191010232345.26594-4-keescook@chromium.org>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Alexey Dobriyan <adobriyan@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Randy Dunlap <rdunlap@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <20191010235027.xI1ws02O8vo8k9ZbLByod5m4yCkQugI1cmNQNVeXdMw@z>

On Thu, 2019-10-10 at 16:23 -0700, Kees Cook wrote:
> From: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
> 
> Replace all the occurrences of FIELD_SIZEOF() and sizeof_field() with
> sizeof_member() except at places where these are defined. Later patches
> will remove the unused definitions.
> 
> This patch is generated using following script:
> 
> EXCLUDE_FILES="include/linux/stddef.h|include/linux/kernel.h"
> 
> git grep -l -e "\bFIELD_SIZEOF\b" -e "\bsizeof_field\b" | while read file;
> do
> 
> 	if [[ "$file" =~ $EXCLUDE_FILES ]]; then
> 		continue
> 	fi
> 	sed -i  -e 's/\bFIELD_SIZEOF\b/sizeof_member/g' \
> 		-e 's/\bsizeof_field\b/sizeof_member/g' \
> 		$file;
> done

While the sed works, a cocci script would perhaps
be better as multi line argument realignment would
also occur.

$ cat sizeof_member.cocci
@@
@@

-	FIELD_SIZEOF
+	sizeof_member

@@
@@

-	sizeof_field
+	sizeof_member
$

For instance, this sed produces:

diff --git a/crypto/adiantum.c b/crypto/adiantum.c
@@ -435,10 +435,10 @@ static int adiantum_init_tfm(struct crypto_skcipher *tfm)
 
 	BUILD_BUG_ON(offsetofend(struct adiantum_request_ctx, u) !=
 		     sizeof(struct adiantum_request_ctx));
-	subreq_size = max(FIELD_SIZEOF(struct adiantum_request_ctx,
+	subreq_size = max(sizeof_member(struct adiantum_request_ctx,
 				       u.hash_desc) +
 			  crypto_shash_descsize(hash),
-			  FIELD_SIZEOF(struct adiantum_request_ctx,
+			  sizeof_member(struct adiantum_request_ctx,
 				       u.streamcipher_req) +
 			  crypto_skcipher_reqsize(streamcipher));
 

where the cocci script produces:

--- crypto/adiantum.c
+++ /tmp/cocci-output-22881-d8186c-adiantum.c
@@ -435,11 +435,11 @@ static int adiantum_init_tfm(struct cryp
 
 	BUILD_BUG_ON(offsetofend(struct adiantum_request_ctx, u) !=
 		     sizeof(struct adiantum_request_ctx));
-	subreq_size = max(FIELD_SIZEOF(struct adiantum_request_ctx,
-				       u.hash_desc) +
+	subreq_size = max(sizeof_member(struct adiantum_request_ctx,
+					u.hash_desc) +
 			  crypto_shash_descsize(hash),
-			  FIELD_SIZEOF(struct adiantum_request_ctx,
-				       u.streamcipher_req) +
+			  sizeof_member(struct adiantum_request_ctx,
+					u.streamcipher_req) +
 			  crypto_skcipher_reqsize(streamcipher));
 
 	crypto_skcipher_set_reqsize(tfm,
