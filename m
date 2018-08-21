From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [Skiboot] [PATCH] opal/hmi: Wakeup the cpu before reading
 core_fir
Date: Tue, 21 Aug 2018 13:38:42 +1000
Message-ID: <20180821133842.1b13e972@roar.ozlabs.ibm.com>
References: <20180820183417.dejfsluih7elbclu@pburton-laptop>
        <20180820223618.22319-1-paul.burton@mips.com>
        <20180820223618.22319-2-paul.burton@mips.com>
        <20180820140605.11846-1-vaibhav@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820140605.11846-1-vaibhav@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Michael Neuling <mikey@neuling.org>, Stewart Smith <stewart@linux.ibm.com>, Linux-MIPS <linux-mips@linux-mips.org>, linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, James Hogan <jhogan@kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-arch.vger.kernel.org

On Mon, 20 Aug 2018 19:36:05 +0530
Vaibhav Jain <vaibhav@linux.ibm.com> wrote:

> When stop state 5 is enabled, reading the core_fir during an HMI can
> result in a xscom read error with xscom_read() returning the
> OPAL_XSCOM_PARTIAL_GOOD error code and core_fir value of all FFs. At
> present this return error code is not handled in decode_core_fir()
> hence the invalid core_fir value is sent to the kernel where it
> interprets it as a FATAL hmi causing a system check-stop.
> 
> This can be prevented by forcing the core to wake-up using before
> reading the core_fir. Hence this patch wraps the call to
> read_core_fir() within calls to dctl_set_special_wakeup() and
> dctl_clear_special_wakeup().

Would it be feasible to enumerate the ranges of scoms that require
special wakeup and check for those in xscom_read/write, and warn if
spwkup was not set?

Thanks,
Nick

> 
> Suggested-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Signed-off-by: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
>  core/hmi.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/core/hmi.c b/core/hmi.c
> index 1f665a2f..67c520a0 100644
> --- a/core/hmi.c
> +++ b/core/hmi.c
> @@ -379,7 +379,7 @@ static bool decode_core_fir(struct cpu_thread *cpu,
>  {
>  	uint64_t core_fir;
>  	uint32_t core_id;
> -	int i;
> +	int i, swkup_rc = OPAL_UNSUPPORTED;
>  	bool found = false;
>  	int64_t ret;
>  	const char *loc;
> @@ -390,14 +390,15 @@ static bool decode_core_fir(struct cpu_thread *cpu,
>  
>  	core_id = pir_to_core_id(cpu->pir);
>  
> +	/* Force the core to wakeup, otherwise reading core_fir is unrealiable
> +	 * if stop-state 5 is enabled.
> +	 */
> +	swkup_rc = dctl_set_special_wakeup(cpu);
> +
>  	/* Get CORE FIR register value. */
>  	ret = read_core_fir(cpu->chip_id, core_id, &core_fir);
>  
> -	if (ret == OPAL_HARDWARE) {
> -		prerror("XSCOM error reading CORE FIR\n");
> -		/* If the FIR can't be read, we should checkstop. */
> -		return true;
> -	} else if (ret == OPAL_WRONG_STATE) {
> +	if (ret == OPAL_WRONG_STATE) {
>  		/*
>  		 * CPU is asleep, so it probably didn't cause the checkstop.
>  		 * If no other HMI cause is found a "catchall" checkstop
> @@ -407,11 +408,16 @@ static bool decode_core_fir(struct cpu_thread *cpu,
>  		prlog(PR_DEBUG,
>  		      "FIR read failed, chip %d core %d asleep\n",
>  		      cpu->chip_id, core_id);
> -		return false;
> +		goto out;
> +	} else if (ret != OPAL_SUCCESS) {
> +		prerror("XSCOM error reading CORE FIR\n");
> +		/* If the FIR can't be read, we should checkstop. */
> +		found = true;
> +		goto out;
>  	}
>  
>  	if (!core_fir)
> -		return false;
> +		goto out;
>  
>  	loc = chip_loc_code(cpu->chip_id);
>  	prlog(PR_INFO, "[Loc: %s]: CHIP ID: %x, CORE ID: %x, FIR: %016llx\n",
> @@ -426,6 +432,9 @@ static bool decode_core_fir(struct cpu_thread *cpu,
>  						|= xstop_bits[i].reason;
>  		}
>  	}
> +out:
> +	if (!swkup_rc)
> +		dctl_clear_special_wakeup(cpu);
>  	return found;
>  }
>  
