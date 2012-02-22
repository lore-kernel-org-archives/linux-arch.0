From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 09/11] powerpc/PCI: replace pci_probe_only with pci_flags
Date: Wed, 22 Feb 2012 14:47:00 -0800
Message-ID: <CAErSpo7bMNbZgEZFmezJwTvGGoRsCe-qZavBJZS_q4DmnNAE7A@mail.gmail.com>
References: <20120222181556.27513.9413.stgit@bhelgaas.mtv.corp.google.com>
 <20120222181948.27513.96215.stgit@bhelgaas.mtv.corp.google.com> <1329946909.20389.10.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1329946909.20389.10.camel@pasglop>
Sender: linux-pci-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

On Wed, Feb 22, 2012 at 1:41 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2012-02-22 at 11:19 -0700, Bjorn Helgaas wrote:
>> We already use pci_flags, so this just sets pci_flags directly and r=
emoves
>> the intermediate step of figuring out pci_probe_only, then using it =
to set
>> pci_flags.
>
> Ah yes, those flags are now common indeed.
>
>> The PCI core provides a pci_flags definition (currently __weak), so =
drop
>> the powerpc definitions in favor of that. =A0Note that we must set t=
he ppc64
>> default (PCI_PROBE_ONLY set) in the 64-bit setup_arch() before calli=
ng
>> the platform .setup_arch() method, which may override the default.
>
> Ah wait, I have a patch about to hit -next that flips the ppc64
> default...
>
> Maybe it's easier if you just pick it up and stick it in your series,
> that will avoid integration clashes..
>
> http://patchwork.ozlabs.org/patch/141225/

Sure, I'll pick up that patch and repost the series.  I'll wait until
tomorrow or so in case anybody else has comments.

Thanks,
  Bjorn
