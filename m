Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35219 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfJ2WaV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Oct 2019 18:30:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id c8so93368pgb.2
        for <linux-arch@vger.kernel.org>; Tue, 29 Oct 2019 15:30:20 -0700 (PDT)
Date: Tue, 29 Oct 2019 15:30:18 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 3/4] treewide: Use sizeof_member() macro
Message-ID: <201910291527.ED0E642@keescook>
References: <20191010232345.26594-1-keescook@chromium.org>
 <20191010232345.26594-4-keescook@chromium.org>
 <2231d5f0a82f880e6706e2d0f070328a029c9b21.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2231d5f0a82f880e6706e2d0f070328a029c9b21.camel@perches.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Alexey Dobriyan <adobriyan@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Randy Dunlap <rdunlap@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <20191029223018.GB5DG15JoPuHvKjSbjWwYmm2k5BFEjhC6EPboRqbag8@z>

On Thu, Oct 10, 2019 at 04:50:27PM -0700, Joe Perches wrote:
> On Thu, 2019-10-10 at 16:23 -0700, Kees Cook wrote:
> > From: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
> > 
> > Replace all the occurrences of FIELD_SIZEOF() and sizeof_field() with
> > sizeof_member() except at places where these are defined. Later patches
> > will remove the unused definitions.
> > 
> > This patch is generated using following script:
> > 
> > EXCLUDE_FILES="include/linux/stddef.h|include/linux/kernel.h"
> > 
> > git grep -l -e "\bFIELD_SIZEOF\b" -e "\bsizeof_field\b" | while read file;
> > do
> > 
> > 	if [[ "$file" =~ $EXCLUDE_FILES ]]; then
> > 		continue
> > 	fi
> > 	sed -i  -e 's/\bFIELD_SIZEOF\b/sizeof_member/g' \
> > 		-e 's/\bsizeof_field\b/sizeof_member/g' \
> > 		$file;
> > done
> 
> While the sed works, a cocci script would perhaps
> be better as multi line argument realignment would
> also occur.
> 
> $ cat sizeof_member.cocci
> @@
> @@
> 
> -	FIELD_SIZEOF
> +	sizeof_member
> 
> @@
> @@
> 
> -	sizeof_field
> +	sizeof_member
> $
> 
> For instance, this sed produces:
> 
> diff --git a/crypto/adiantum.c b/crypto/adiantum.c
> @@ -435,10 +435,10 @@ static int adiantum_init_tfm(struct crypto_skcipher *tfm)
>  
>  	BUILD_BUG_ON(offsetofend(struct adiantum_request_ctx, u) !=
>  		     sizeof(struct adiantum_request_ctx));
> -	subreq_size = max(FIELD_SIZEOF(struct adiantum_request_ctx,
> +	subreq_size = max(sizeof_member(struct adiantum_request_ctx,
>  				       u.hash_desc) +
>  			  crypto_shash_descsize(hash),
> -			  FIELD_SIZEOF(struct adiantum_request_ctx,
> +			  sizeof_member(struct adiantum_request_ctx,
>  				       u.streamcipher_req) +
>  			  crypto_skcipher_reqsize(streamcipher));
>  
> 
> where the cocci script produces:
> 
> --- crypto/adiantum.c
> +++ /tmp/cocci-output-22881-d8186c-adiantum.c
> @@ -435,11 +435,11 @@ static int adiantum_init_tfm(struct cryp
>  
>  	BUILD_BUG_ON(offsetofend(struct adiantum_request_ctx, u) !=
>  		     sizeof(struct adiantum_request_ctx));
> -	subreq_size = max(FIELD_SIZEOF(struct adiantum_request_ctx,
> -				       u.hash_desc) +
> +	subreq_size = max(sizeof_member(struct adiantum_request_ctx,
> +					u.hash_desc) +
>  			  crypto_shash_descsize(hash),
> -			  FIELD_SIZEOF(struct adiantum_request_ctx,
> -				       u.streamcipher_req) +
> +			  sizeof_member(struct adiantum_request_ctx,
> +					u.streamcipher_req) +
>  			  crypto_skcipher_reqsize(streamcipher));
>  
>  	crypto_skcipher_set_reqsize(tfm,

I played with this a bit, and it seems Coccinelle can get this very very
wrong:

diff -u -p a/drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c
--- a/drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c
@@ -87,13 +87,13 @@ static const struct rhashtable_params rh
 	 * value is not constant during the lifetime
 	 * of the key object.
 	 */
-	.key_len = FIELD_SIZEOF(struct mlx5_fpga_ipsec_sa_ctx, hw_sa) -
-		   FIELD_SIZEOF(struct mlx5_ifc_fpga_ipsec_sa_v1, cmd),
+	.key_len = sizeof_member(struct mlx5_fpga_ipsec_sa_ctx, hw_sa) -
+	sizeof_member(struct mlx5_ifc_fpga_ipsec_sa_v1, cmd),
 	.key_offset = offsetof(struct mlx5_fpga_ipsec_sa_ctx, hw_sa) +
-		      FIELD_SIZEOF(struct mlx5_ifc_fpga_ipsec_sa_v1, cmd),
-	.head_offset = offsetof(struct mlx5_fpga_ipsec_sa_ctx, hash),
-	.automatic_shrinking = true,
-	.min_size = 1,
+		      sizeof_member(struct mlx5_ifc_fpga_ipsec_sa_v1, cmd),
+		      .head_offset = offsetof(struct mlx5_fpga_ipsec_sa_ctx, hash),
+		      .automatic_shrinking = true,
+		      .min_size = 1,
 };
 
 struct mlx5_fpga_ipsec {


So, since the sed is faster and causes fewer problems, I'll keep it
as-is.

-- 
Kees Cook
