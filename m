From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Subject: Re: [RFC PATCH 2/2] kbuild: introduce cmd_dtc_cpp
Date: Sat, 29 Sep 2012 22:02:22 +0200
Message-ID: <20120929200222.GC31527@game.jcrosoft.org>
References: <1348860731-20868-1-git-send-email-swarren@wwwdotorg.org>
 <1348860731-20868-3-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1348860731-20868-3-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On 13:32 Fri 28 Sep     , Stephen Warren wrote:
> From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> cmd_dtc_cpp runs the C pre-processor on the input .dts file before
> passing it to dtc for final compilation. This allows used of #define
> within the .dts file.
> 
> Introduce a new rule for %.dtsp -> %.dtb, which uses cmd_dtc_cpp. A new
> file extension is introduced for this purpose, since use of the pre-
> processor must be optional; any property or node name that starts with
> "#" must be escaped to prevent the pre-processor attempting to interpret
> it as a directive. For this reason, skeleton.dtsi-cpp is introduced for
> *.dts-cpp to include.
> 
> Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/arm/boot/dts/skeleton.dtsip |   13 +++++++++++++
>  scripts/Makefile.lib             |    6 ++++++
>  2 files changed, 19 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/skeleton.dtsip
> 
> diff --git a/arch/arm/boot/dts/skeleton.dtsip b/arch/arm/boot/dts/skeleton.dtsip
> new file mode 100644
> index 0000000..8bf6729
> --- /dev/null
> +++ b/arch/arm/boot/dts/skeleton.dtsip
> @@ -0,0 +1,13 @@
> +/*
> + * Skeleton device tree; the bare minimum needed to boot; just include and
> + * add a compatible value.  The bootloader will typically populate the memory
> + * node.
> + */
> +
> +/ {
> +	\#address-cells = <1>;
> +	\#size-cells = <1>;
> +	chosen { };
> +	aliases { };
> +	memory { device_type = "memory"; reg = <0 0>; };
> +};
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 425578e..9dd81c0 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -269,6 +269,12 @@ cmd_dtc = $(objtree)/scripts/dtc/dtc -O dtb -o $@ -b 0 $(DTC_FLAGS) -d $(depfile
>  $(obj)/%.dtb: $(src)/dts/%.dts FORCE
>  	$(call if_changed_dep,dtc)
>  
> +quiet_cmd_dtc_cpp = DTC+CPP $@
> +cmd_dtc_cpp = $(CC) -E -Wp,-MD,$(depfile) -xc $< | $(objtree)/scripts/dtc/dtc -O dtb -o $@ -b 0 $(DTC_FLAGS) -
> +
> +$(obj)/%.dtb: $(src)/dts/%.dtsp FORCE
> +	$(call if_changed_dep,dtc_cpp)
> +
here no this is build stuff move it to Makefile.build

Best Regards,
J.
