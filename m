From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v2] of: unflatten_and_copy: handle NULL initial_boot_params
Date: Thu, 21 Nov 2013 13:49:51 +0000
Message-ID: <528E0F7F.7010901@imgtec.com>
References: <1385041454-32385-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:30264 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751491Ab3KUNty (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 21 Nov 2013 08:49:54 -0500
In-Reply-To: <1385041454-32385-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, devicetree@vger.kernel.org
Cc: James Hogan <james.hogan@imgtec.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On 21/11/13 13:44, James Hogan wrote:
> Check whether initial_boot_params is NULL before dereferencing it in
> unflatten_and_copy_device_tree() for the case where no device tree is
> available but the arch can still boot to a minimal usable system without
> it. In this case also log a warning for when the kernel log buffer is
> obtainable.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arch@vger.kernel.org

Hmm, sorry, I forgot to add Grant's:
Acked-by: Grant Likely <grant.likely@linaro.org>

(from v1)

Cheers
James

> ---
> v2:
>  * Log a warning for those who can obtain the kernel log buffer (Grant
>    Likely).
> ---
>  drivers/of/fdt.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 2fa024b97c43..758b4f8b30b7 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -922,8 +922,16 @@ void __init unflatten_device_tree(void)
>   */
>  void __init unflatten_and_copy_device_tree(void)
>  {
> -	int size = __be32_to_cpu(initial_boot_params->totalsize);
> -	void *dt = early_init_dt_alloc_memory_arch(size,
> +	int size;
> +	void *dt;
> +
> +	if (!initial_boot_params) {
> +		pr_warn("No valid device tree found, continuing without\n");
> +		return;
> +	}
> +
> +	size = __be32_to_cpu(initial_boot_params->totalsize);
> +	dt = early_init_dt_alloc_memory_arch(size,
>  		__alignof__(struct boot_param_header));
>  
>  	if (dt) {
> 
