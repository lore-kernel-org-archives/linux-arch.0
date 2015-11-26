From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 2/2] restrict /dev/mem to idle io memory ranges
Date: Thu, 26 Nov 2015 12:08:55 +0100
Message-ID: <20151126110855.GA32226@gmail.com>
References: <20151124000553.26360.57819.stgit@dwillia2-desk3.jf.intel.com>
 <20151124000604.26360.56945.stgit@dwillia2-desk3.jf.intel.com>
 <20151124142521.e6d23e44a8b2c24c044c2dec@linux-foundation.org>
 <CAPcyv4ijWns879DytqUa+=r5hzQ1qzmB83VV6Z16kQNtmHUtbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAPcyv4ijWns879DytqUa+=r5hzQ1qzmB83VV6Z16kQNtmHUtbA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org


* Dan Williams <dan.j.williams@intel.com> wrote:

> > - why is the patch mucking with access to PCI and BIOS space?  Is the
> >   persistent memory even mappable in those regions?  Or is the concern
> >   that userspace can access control registers associated with the
> >   persistent memory?  What is the problem scenario?
> 
> It seems to me that letting /dev/mem do arbitrary access to any region
> of memory is a dangerous capability for a production environment.

So basically the original motivation years ago was to disable /dev/mem altogether: 
it used to be a wide open roothole if anything with write access to it (such as 
old Xorg) is exploited, plus it's a favorite and convenient tool for stealth 
access to system areas of memory in cases where the attacker already has root. 

(this is relevant as even being root might not give easy access to system mmio 
areas if things like being able to load modules is restricted even for room, and 
if the system has readonly storage and a few other things configured.)

But we couldn't disable /dev/mem completely due to Xorg and dosemu legacies - so 
we came up with this restriction feature that limits its scope.

Any additional steps that limit the scope of access under the STRICT_DEVMEM option 
(which is really a misnomer: it should be RESTRICT_DEVMEM instead) are welcome 
from a generic Linux distro POV.

Thanks,

	Ingo
