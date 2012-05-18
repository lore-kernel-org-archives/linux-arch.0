From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 05/21] resource: adjust_resource handle resource without parent
Date: Fri, 18 May 2012 12:06:42 -0600
Message-ID: <CAErSpo79gZFGOGdA201r1aAPzE9a1=CtFK7XPbsOjVvRLfNJ3A@mail.gmail.com>
References: <1336422606-4244-1-git-send-email-yinghai@kernel.org>
 <1336422606-4244-6-git-send-email-yinghai@kernel.org> <CAErSpo71rKrZ7ptJjE5Lb6YnrqXVe1eGhn3pyF2Qjp=o8JHQmg@mail.gmail.com>
 <CAE9FiQUebVR_AdhQVE_Hq-RhB7h5AfH0Z20WaZh=ky5vHEt5BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAE9FiQUebVR_AdhQVE_Hq-RhB7h5AfH0Z20WaZh=ky5vHEt5BQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, May 18, 2012 at 11:54 AM, Yinghai Lu <yinghai@kernel.org> wrote=
:
> On Fri, May 18, 2012 at 10:12 AM, Bjorn Helgaas <bhelgaas@google.com>=
 wrote:
>> On Mon, May 7, 2012 at 2:29 PM, Yinghai Lu <yinghai@kernel.org> wrot=
e:
>
>> Where does this case occur? =A0When do you need to adjust a resource
>> that has no parent?
>
> for unassigned pci bridge from BIOS, before scan busn_res.end is 0xff=
,
> so you can not insert them, because the bridge could in the middle.
> Have to update the busn_res.end and insert after the bridge is scanne=
d

Does the resource have children in this case?  If it has no parent,
it's not in the resource tree at all, is it?  Is there any reason to
use adjust_resource() rather than just updating res->start and
res->end directly?
