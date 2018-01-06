From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 12/18] Thermal/int340x: prevent bounds-check bypass via
 speculative execution
Date: Sat, 6 Jan 2018 13:03:22 +0300
Message-ID: <b1d114af-c0ba-63f5-0905-86128d3c0b3a@cogentembedded.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520105920.32271.1091443154687576996.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <151520105920.32271.1091443154687576996.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, gregkh@linuxfoundation.org, peterz@infradead.org, netdev@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, torvalds@linux-foundation.org, tglx@linutronix.de, Elena Reshetova <elena.reshetova@intel.com>, alan@linux.intel.com
List-Id: linux-arch.vger.kernel.org

On 1/6/2018 4:10 AM, Dan Williams wrote:

> Static analysis reports that 'trip' may be a user controlled value that
> is used as a data dependency to read '*temp' from the 'd->aux_trips'
> array.  In order to avoid potential leaks of kernel memory values, block
> speculative execution of the instruction stream that could issue reads
> based on an invalid value of '*temp'.
> 
> Based on an original patch by Elena Reshetova.
> 
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   .../thermal/int340x_thermal/int340x_thermal_zone.c |   14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/int340x_thermal/int340x_thermal_zone.c
> index 145a5c53ff5c..442a1d9bf7ad 100644
> --- a/drivers/thermal/int340x_thermal/int340x_thermal_zone.c
> +++ b/drivers/thermal/int340x_thermal/int340x_thermal_zone.c
[...]
> @@ -52,20 +53,21 @@ static int int340x_thermal_get_trip_temp(struct thermal_zone_device *zone,
>   					 int trip, int *temp)
>   {
>   	struct int34x_thermal_zone *d = zone->devdata;
> +	unsigned long *elem;
>   	int i;
>   
>   	if (d->override_ops && d->override_ops->get_trip_temp)
>   		return d->override_ops->get_trip_temp(zone, trip, temp);
>   
> -	if (trip < d->aux_trip_nr)
> -		*temp = d->aux_trips[trip];
> -	else if (trip == d->crt_trip_id)
> +	if ((elem = nospec_array_ptr(d->aux_trips, trip, d->aux_trip_nr))) {

    And here...

> +		*temp = *elem;
> +	} else if (trip == d->crt_trip_id) {
>   		*temp = d->crt_temp;
> -	else if (trip == d->psv_trip_id)
> +	} else if (trip == d->psv_trip_id) {
>   		*temp = d->psv_temp;
> -	else if (trip == d->hot_trip_id)
> +	} else if (trip == d->hot_trip_id) {
>   		*temp = d->hot_temp;
> -	else {
> +	} else {
>   		for (i = 0; i < INT340X_THERMAL_MAX_ACT_TRIP_COUNT; i++) {
>   			if (d->act_trips[i].valid &&
>   			    d->act_trips[i].id == trip) {

MBR, Sergei
