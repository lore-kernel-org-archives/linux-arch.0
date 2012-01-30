From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC PATCH v1 14/18] powerpc/PCI: get rid of device resource fixups
Date: Mon, 30 Jan 2012 13:46:35 -0800
Message-ID: <CAErSpo7qV084bxjfds=oaZ45xDB4=u78T6UmjpmbDWd3yBcCmA@mail.gmail.com>
References: <20120130165430.3231.97740.stgit@bhelgaas.mtv.corp.google.com>
 <20120130165820.3231.9878.stgit@bhelgaas.mtv.corp.google.com> <1327956544.28487.47.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1327956544.28487.47.camel@pasglop>
Sender: linux-pci-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 30, 2012 at 12:49 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Mon, 2012-01-30 at 09:58 -0700, Bjorn Helgaas wrote:
>> Tell the PCI core about host bridge address translation so it can ta=
ke
>> care of bus-to-resource conversion for us.
>>
>> N.B. powerpc used a 32-bit mask when converting IO addresses. =A0If =
we
>> figure out the right offset, I think simple addition should do the
>> same thing, but I might not have it exactly right yet.
>
> Wow that's going to be a big change :-) A quick look... seems like yo=
u
> do a per-resource offset right ? I will need that (was about to chang=
e
> powerpc) as we have hardware that provides us with two different wind=
ows
> to MMIO space with different offsets unfortunately.

Exactly ... the offset is per-aperture.

> One thing I also want to generalize is the whole "REASSIGN_ALL_RSRC"
> flag, ie, avoid reading & printing all those resources we know we are
> just going to kill off.
>
> I'll try to test your stuff asap (I'm doing 3 things at once right no=
w
> so it might take a few days unless I find somebody to look at it).

Thanks!  No particular rush on my side; I'm expecting to have to
iterate a few times to get this right.

Bjorn
