From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 1/3] arm64: enable pci resource mapping using sysfs
Date: Mon, 20 Mar 2017 10:24:04 +0000
Message-ID: <20170320102403.GC17263@arm.com>
References: <1489598266.86622.12.camel@infradead.org>
 <20170315175353.GA29452@leverpostej>
 <1489605496.4195.182.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1489605496.4195.182.camel@infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 15, 2017 at 07:18:16PM +0000, David Woodhouse wrote:
> On Wed, 2017-03-15 at 17:54 +0000, Mark Rutland wrote:
> > It's not so much "broken" as "not currently supported".
> =

> Yeah, I thought that when I inherited the commit, but didn't get as far
> as rephrasing it. Will do so.
> =

> > [...]
> > =

> > > =

> > > +#define HAVE_PCI_MMAP
> > > +extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_s=
truct *vma,
> > > +			=A0=A0=A0=A0=A0=A0=A0enum pci_mmap_state mmap_state, int write_co=
mbine);
> > > +
> > Per the prior attempt at this [1], we only want to expose the sysfs
> > interface, and not the legacy procfs interface, and need the two
> > decoupled [2].
> =

> I do not like that idea. The procfs horridness is legacy, sure, but
> it's not actually an arch-specific interface. You get to mess with
> 'legacy' syscalls all you like on a new architecture, but there could
> exist arch-agnostic code which uses the procfs interface, surely?

Just to be clear here: I'm not against exposing the proc interface if
something actually needs it, but all the requests we've had for this have
been concerned only with the sysfs API. So I'd rather start with just that,
instead of exposing both and have new software written to the proc interfac=
e,
which we certainly want to discourage.

Will
