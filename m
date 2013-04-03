From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] Kbuild: Avoid DTB rebuilds if source files are untouched
Date: Wed, 3 Apr 2013 12:44:00 +0530
Message-ID: <515BD6B8.1020607@synopsys.com>
References: <1364973141-16354-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1364973141-16354-1-git-send-email-vgupta@synopsys.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org, Michal Marek <mmarek@suse.cz>, Stephen Warren <swarren@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, linux-kbuild@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

forgot to CC linux-arch

On 04/03/2013 12:42 PM, Vineet Gupta wrote:
> Currently, for every ARC kernel build I see the following:
>
> --------------->8-----------------
>   DTB    arch/arc/boot/dts/angel4.dtb.S
>   AS      arch/arc/boot/dts/angel4.dtb.o
>   LD      arch/arc/boot/dts/built-in.o
> rm arch/arc/boot/dts/angel4.dtb.S        <-- forces rebuild next iter
>   CHK     kernel/config_data.h
> --------------->8-----------------
>
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> Cc: Michal Marek <mmarek@suse.cz>
> Cc: Stephen Warren <swarren@nvidia.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  scripts/Makefile.lib |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 07125e6..17f96f4 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -265,6 +265,8 @@ cmd_dt_S_dtb=						\
>  	echo '.balign STRUCT_ALIGNMENT'; 		\
>  ) > $@
>  
> +.PRECIOUS: $(obj)/%.dtb.S
> +
>  $(obj)/%.dtb.S: $(obj)/%.dtb
>  	$(call cmd,dt_S_dtb)
>  

