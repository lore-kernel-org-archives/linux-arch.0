From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH 13/18] ipv6: prevent bounds-check bypass via speculative
 execution
Date: Sat, 6 Jan 2018 06:48:52 -0800
Message-ID: <20180106064852.187637ad@xeon-e3>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
        <151520106487.32271.6013001625427346680.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:32773 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753340AbeAFOs5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 6 Jan 2018 09:48:57 -0500
Received: by mail-pl0-f66.google.com with SMTP id 1so4912069plv.0
        for <linux-arch@vger.kernel.org>; Sat, 06 Jan 2018 06:48:57 -0800 (PST)
In-Reply-To: <151520106487.32271.6013001625427346680.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, tglx@linutronix.de, torvalds@linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Elena Reshetova <elena.reshetova@intel.com>, alan@linux.intel.com

On Fri, 05 Jan 2018 17:11:04 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Static analysis reports that 'offset' may be a user controlled value
> that is used as a data dependency reading from a raw6_frag_vec buffer.
> In order to avoid potential leaks of kernel memory values, block
> speculative execution of the instruction stream that could issue further
> reads based on an invalid '*(rfv->c + offset)' value.
> 
> Based on an original patch by Elena Reshetova.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
> Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  net/ipv6/raw.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
> index 761a473a07c5..384e3d59d148 100644
> --- a/net/ipv6/raw.c
> +++ b/net/ipv6/raw.c
> @@ -33,6 +33,7 @@
>  #include <linux/skbuff.h>
>  #include <linux/compat.h>
>  #include <linux/uaccess.h>
> +#include <linux/compiler.h>
>  #include <asm/ioctls.h>
>  
>  #include <net/net_namespace.h>
> @@ -725,17 +726,17 @@ static int raw6_getfrag(void *from, char *to, int offset, int len, int odd,
>  		       struct sk_buff *skb)
>  {
>  	struct raw6_frag_vec *rfv = from;
> +	char *rfv_buf;
>  
> -	if (offset < rfv->hlen) {
> +	if ((rfv_buf = nospec_array_ptr(rfv->c, offset, rfv->hlen))) {
>  		int copy = min(rfv->hlen - offset, len);

Minor nit.

Please don't do assignment in condition test here.
Instead.
	rfv_buf = nospec_array_ptr(rfv->c, offset, rfv->hlen);
	if (rfv_buf) {

	
