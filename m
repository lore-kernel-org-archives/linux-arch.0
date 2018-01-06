From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 13/18] ipv6: prevent bounds-check bypass via speculative
 execution
Date: Sat, 6 Jan 2018 13:04:05 +0300
Message-ID: <9df738f5-65d9-4560-4b8b-120813a203ce@cogentembedded.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520106487.32271.6013001625427346680.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <151520106487.32271.6013001625427346680.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, peterz@infradead.org, gregkh@linuxfoundation.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, tglx@linutronix.de, torvalds@linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Elena Reshetova <elena.reshetova@intel.com>, alan@linux.intel.com
List-Id: linux-arch.vger.kernel.org

On 1/6/2018 4:11 AM, Dan Williams wrote:

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
>   net/ipv6/raw.c |    9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
> index 761a473a07c5..384e3d59d148 100644
> --- a/net/ipv6/raw.c
> +++ b/net/ipv6/raw.c
[...]
> @@ -725,17 +726,17 @@ static int raw6_getfrag(void *from, char *to, int offset, int len, int odd,
>   		       struct sk_buff *skb)
>   {
>   	struct raw6_frag_vec *rfv = from;
> +	char *rfv_buf;
>   
> -	if (offset < rfv->hlen) {
> +	if ((rfv_buf = nospec_array_ptr(rfv->c, offset, rfv->hlen))) {

    And here...

>   		int copy = min(rfv->hlen - offset, len);
>   
>   		if (skb->ip_summed == CHECKSUM_PARTIAL)
> -			memcpy(to, rfv->c + offset, copy);
> +			memcpy(to, rfv_buf, copy);
>   		else
>   			skb->csum = csum_block_add(
>   				skb->csum,
> -				csum_partial_copy_nocheck(rfv->c + offset,
> -							  to, copy, 0),
> +				csum_partial_copy_nocheck(rfv_buf, to, copy, 0),
>   				odd);
>   
>   		odd = 0;

MBR, Sergei
