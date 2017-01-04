From: Christoffer Dall <christoffer.dall@linaro.org>
Subject: Re: [PATCH 02/13] KVM: arm: fix gcc-4.5 build
Date: Wed, 4 Jan 2017 11:38:33 +0100
Message-ID: <20170104103833.GB20461@cbox>
References: <20161216105634.235457-1-arnd@arndb.de>
 <20161216105634.235457-3-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
Content-Disposition: inline
In-Reply-To: <20161216105634.235457-3-arnd@arndb.de>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, kernel-build-reports@lists.linaro.org, linux-kernel@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Dec 16, 2016 at 11:56:23AM +0100, Arnd Bergmann wrote:
> Old gcc versions cannot used named initializers for anonymous
> unions, leading to a build failure here. This replaces the anonymous
> union with a named one, which allows us to build with at least gcc-4.3
> through 4.5. Versions 4.6 and higher are fine without this.
> 
> virt/kvm/arm/vgic/vgic-mmio-v2.c:295: error: unknown field 'read' specified in initializer
> virt/kvm/arm/vgic/vgic-mmio-v2.c:295: warning: missing braces around initializer
> virt/kvm/arm/vgic/vgic-mmio-v2.c:295: warning: (near initialization for 'vgic_v2_dist_registers[0].<anonymous>')
> virt/kvm/arm/vgic/vgic-mmio-v2.c:295: error: unknown field 'write' specified in initializer
> virt/kvm/arm/vgic/vgic-mmio-v2.c:298: error: unknown field 'read' specified in initializer
> 
> Fixes: 59c5ab40989a ("KVM: arm64: vgic-its: Introduce ITS emulation file with MMIO framework")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

If this series is moving ahead, I have no problems with this patch:

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
