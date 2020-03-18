From: Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v6 03/10] arm64: hyperv: Add hypercall and register access
 functions
Date: Wed, 18 Mar 2020 11:11:30 +0800
Message-ID: <20200318031130.5476-1-hdanton@sina.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Michael Kelley <mikelley@microsoft.com>
Cc: mark.rutland@arm.com, linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org, boqun.feng@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org, catalin.marinas@arm.com, jasowang@redhat.com, sunilmut@microsoft.com, linux-kernel@vger.kernel.org, marcelo.cerri@canonical.com, olaf@aepfle.de, maz@kernel.org, apw@canonical.com, vkuznets@redhat.com, kys@microsoft.com, will@kernel.org, ardb@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org


On Sat, 14 Mar 2020 08:35:12 -0700 Michael Kelley wrote:
> +/*
> + * Get the value of a single VP register.  One version
> + * returns just 64 bits and another returns the full 128 bits.
> + * The two versions are separate to avoid complicating the
> + * calling sequence for the more frequently used 64 bit version.
> + */
> +
> +/*
> + * Input and output memory allocation sizes are rounded up to a power
> + * of 2 so kmalloc() will guarantee alignment. In turn, the alignment
> + * ensures that the allocations don't cross a page boundary, which is

Better to specify kmalloc's current alignment and why it fails to ensure
(4 * sizeof(u64))-sized allocations wont cross page boundary.

> + * required by the hypercall interface.
> + */
> +#define INPUTSIZE (4 * sizeof(u64))
> +#define OUTPUTSIZE (2 * sizeof(u64))
> +
> +static void __hv_get_vpreg_128(u32 msr, struct hv_get_vp_register_output *res)
> +{
> +	union hv_hypercall_status		status;
> +	struct hv_get_vp_register_input		*input;
> +
> +	BUILD_BUG_ON(sizeof(*input) > INPUTSIZE);
> +
> +	input = kzalloc(INPUTSIZE, GFP_ATOMIC);
> +
> +	input->partitionid = HV_PARTITION_ID_SELF;
> +	input->vpindex = HV_VP_INDEX_SELF;
> +	input->inputvtl = 0;
> +	input->name0 = msr;
> +	input->name1 = 0;
> +
> +
> +	status.as_uint64 = hv_do_hypercall(
> +		HVCALL_GET_VP_REGISTERS | HV_HYPERCALL_REP_COUNT_1,
> +		input, res);
> +
> +	/*
> +	 * Something is fundamentally broken in the hypervisor if
> +	 * getting a VP register fails. There's really no way to
> +	 * continue as a guest VM, so panic.
> +	 */
> +	BUG_ON(status.status != HV_STATUS_SUCCESS);
> +
> +	kfree(input);
> +}
