Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38031 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752906AbeAFKGb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 6 Jan 2018 05:06:31 -0500
Received: by mail-lf0-f68.google.com with SMTP id w196so7508541lff.5
        for <linux-arch@vger.kernel.org>; Sat, 06 Jan 2018 02:06:30 -0800 (PST)
Subject: Re: [PATCH 16/18] net: mpls: prevent bounds-check bypass via
 speculative execution
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520108080.32271.16420298348259030860.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <0b4d9292-cf0a-170e-a85a-527d1481ae51@cogentembedded.com>
Date: Sat, 6 Jan 2018 13:06:28 +0300
MIME-Version: 1.0
In-Reply-To: <151520108080.32271.16420298348259030860.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, peterz@infradead.org, netdev@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, gregkh@linuxfoundation.org, tglx@linutronix.de, torvalds@linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Elena Reshetova <elena.reshetova@intel.com>, alan@linux.intel.com
Message-ID: <20180106100628.abgeawhKejwVgwIXkljQCNE35i7-HlDHOdvkBpFg2xg@z>

On 1/6/2018 4:11 AM, Dan Williams wrote:

> Static analysis reports that 'index' may be a user controlled value that
> is used as a data dependency reading 'rt' from the 'platform_label'
> array.  In order to avoid potential leaks of kernel memory values, block
> speculative execution of the instruction stream that could issue further
> reads based on an invalid 'rt' value.
> 
> Based on an original patch by Elena Reshetova.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   net/mpls/af_mpls.c |   12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> index 8ca9915befc8..ebcf0e246cfe 100644
> --- a/net/mpls/af_mpls.c
> +++ b/net/mpls/af_mpls.c
[...]
> @@ -77,12 +78,13 @@ static void rtmsg_lfib(int event, u32 label, struct mpls_route *rt,
>   static struct mpls_route *mpls_route_input_rcu(struct net *net, unsigned index)
>   {
>   	struct mpls_route *rt = NULL;
> +	struct mpls_route __rcu **platform_label =
> +		rcu_dereference(net->mpls.platform_label);
> +	struct mpls_route __rcu **rtp;
>   
> -	if (index < net->mpls.platform_labels) {
> -		struct mpls_route __rcu **platform_label =
> -			rcu_dereference(net->mpls.platform_label);
> -		rt = rcu_dereference(platform_label[index]);
> -	}
> +	if ((rtp = nospec_array_ptr(platform_label, index,


    And here...

> +					net->mpls.platform_labels)))
> +		rt = rcu_dereference(*rtp);
>   	return rt;
>   }
>   

MBR, Sergei
