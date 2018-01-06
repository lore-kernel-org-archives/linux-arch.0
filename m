From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 14/18] ipv4: prevent bounds-check bypass via speculative
 execution
Date: Sat, 6 Jan 2018 13:04:52 +0300
Message-ID: <ed88131b-4da7-9dd5-0590-807ec71466ab@cogentembedded.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520107001.32271.12149241186695668220.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:32985 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752770AbeAFKEy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 6 Jan 2018 05:04:54 -0500
Received: by mail-lf0-f66.google.com with SMTP id j143so7515833lfg.0
        for <linux-arch@vger.kernel.org>; Sat, 06 Jan 2018 02:04:54 -0800 (PST)
In-Reply-To: <151520107001.32271.12149241186695668220.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, tglx@linutronix.de, torvalds@linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Elena Reshetova <elena.reshetova@intel.com>, alan@linux.intel.com

On 1/6/2018 4:11 AM, Dan Williams wrote:

> Static analysis reports that 'offset' may be a user controlled value
> that is used as a data dependency reading from a raw_frag_vec buffer.
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
>   net/ipv4/raw.c |    9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
> index 125c1eab3eaa..f72b20131a15 100644
> --- a/net/ipv4/raw.c
> +++ b/net/ipv4/raw.c
[...]
> @@ -472,17 +473,17 @@ static int raw_getfrag(void *from, char *to, int offset, int len, int odd,
>   		       struct sk_buff *skb)
>   {
>   	struct raw_frag_vec *rfv = from;
> +	char *rfv_buf;
>   
> -	if (offset < rfv->hlen) {
> +	if ((rfv_buf = nospec_array_ptr(rfv->hdr.c, offset, rfv->hlen))) {

    And here...

[...]

MBR, Sergei
