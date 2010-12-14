From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/4] V3 Add ability to link device blob(s) into vmlinux
Date: Tue, 14 Dec 2010 09:24:12 -0800
Message-ID: <4D07A83C.9080707@gmail.com>
References: <cover.1291820033.git.dirk.brandewie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <cover.1291820033.git.dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mmarek-AlSwsSmVLrQ@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On 12/08/2010 07:01 AM, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Dirk Brandewie<dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> This patch set adds the ability to link device tree blobs into
> vmlinux.
>
> Patch 1 implements the changes to include/asm-generic/vmlinux.lds.h and
> adds a generic rule for generating DTB objects to be linked vmlinux.
>
> Patch 2 implements linking a DTB into an x86 image.
>
> Patch 3-4 move {powerpc,microblaze}/boot/Makefile to use the dtc rule
> in patch 1.
>
> This patch set has been tested on x86.
>
> Powerpc and Microblaze have been compile tested with and without patch
> 3 and 4 applied.
>
> Changes from V1:
>
> Documentation added for dtc command in Makefile.lib to
> Documentation/kbuild/makefiles.txt
> Separate DTB_ALIGNMENT define removed.
> FORCE removed from dtc rule.
> Removed hardcoded path to dts files from dtc command.
> Moved %.dtb: %.dts rule to arch specific makefiles.
>
> Patch for adding kernel command line option to pass in dtb_compat
> string dropped from this set will be submitted seperately.
>
> Changes from V2:
>
> Rule to create assembly wrapper for blob changed to use Sam Ravnborgs
> suggested implementation.
>
> Rules in architecture specific Makefiles changed to use the cmd
> function instead of the if_changed function.
>
> Dirk Brandewie (4):
>    of: Add support for linking device tree blobs into vmlinux
>    x86/of: Add building device tree blob(s) into image.
>    of/powerpc: Use generic rule to build dtb's
>    microblaze/of: Use generic rule to build dtb's
>
>   Documentation/kbuild/makefiles.txt |   15 +++++++++++++++
>   arch/microblaze/boot/Makefile      |   12 +++---------
>   arch/powerpc/boot/Makefile         |    8 +++-----
>   arch/x86/platform/ce4100/Makefile  |   10 ++++++++++
>   include/asm-generic/vmlinux.lds.h  |   13 +++++++++++--
>   scripts/Makefile.lib               |   23 +++++++++++++++++++++++
>   6 files changed, 65 insertions(+), 16 deletions(-)
>

Any Comments on this patch set?

--Dirk
