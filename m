From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [patch] mm: vmalloc fix lazy unmapping cache aliasing
Date: Thu, 20 Nov 2008 18:43:38 +0000
Message-ID: <1227206618.14146.77.camel@pc1117.cambridge.arm.com>
References: <20081119045338.GA18697@wotan.suse.de>
	<20081119201715.GA9404@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <20081119201715.GA9404@flint.arm.linux.org.uk>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Russell King <rmk@arm.linux.org.uk>
Cc: Nick Piggin <npiggin@suse.de>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

On Wed, 2008-11-19 at 20:17 +0000, Russell King wrote:
> The reason I ask is that with VIPT caches, the mapping has to be
> present so the hardware knows the physical tag to be flushed, so if
> the mapping has been torn down, we'll get an exception.  _If_ and
> only if we convert flush_cache_vunmap() to be less heavy weight
> than its current flush_cache_all().

I posted a patch for simplifying flush_cache_v(un)map some time ago but
only for the VIPT non-aliasing case. I think we still need it to do
cache flushing for the VIPT aliasing systems.

-- 
Catalin


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
