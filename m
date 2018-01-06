From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 09/18] p54: prevent bounds-check bypass via speculative
 execution
Date: Sat, 6 Jan 2018 13:01:57 +0300
Message-ID: <834cec3e-67a6-3ddb-39a2-76e04ade3cf1@cogentembedded.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520104323.32271.6614158873750932410.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <151520104323.32271.6614158873750932410.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, peterz@infradead.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, Elena Reshetova <elena.reshetova@intel.com>, gregkh@linuxfoundation.org, Christian Lamparter <chunkeey@googlemail.com>, tglx@linutronix.de, torvalds@linux-foundation.org, Kalle Valo <kvalo@codeaurora.org>, alan@linux.intel.com
List-Id: linux-arch.vger.kernel.org

On 1/6/2018 4:10 AM, Dan Williams wrote:

> Static analysis reports that 'queue' may be a user controlled value that
> is used as a data dependency to read from the 'priv->qos_params' array.
> In order to avoid potential leaks of kernel memory values, block
> speculative execution of the instruction stream that could issue reads
> based on an invalid result of 'priv->qos_params[queue]'.
> 
> Based on an original patch by Elena Reshetova.
> 
> Cc: Christian Lamparter <chunkeey@googlemail.com>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: linux-wireless@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/net/wireless/intersil/p54/main.c |    8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/intersil/p54/main.c b/drivers/net/wireless/intersil/p54/main.c
> index ab6d39e12069..85c9cbee35fc 100644
> --- a/drivers/net/wireless/intersil/p54/main.c
> +++ b/drivers/net/wireless/intersil/p54/main.c
[...]
> @@ -411,12 +412,13 @@ static int p54_conf_tx(struct ieee80211_hw *dev,
>   		       const struct ieee80211_tx_queue_params *params)
>   {
>   	struct p54_common *priv = dev->priv;
> +	struct p54_edcf_queue_param *p54_q;
>   	int ret;
>   
>   	mutex_lock(&priv->conf_mutex);
> -	if (queue < dev->queues) {
> -		P54_SET_QUEUE(priv->qos_params[queue], params->aifs,
> -			params->cw_min, params->cw_max, params->txop);
> +	if ((p54_q = nospec_array_ptr(priv->qos_params, queue, dev->queues))) {

    Same complaint here...

> +		P54_SET_QUEUE(p54_q[0], params->aifs, params->cw_min,
> +				params->cw_max, params->txop);
>   		ret = p54_set_edcf(priv);
>   	} else
>   		ret = -EINVAL;
> 

MBR, Sergei
