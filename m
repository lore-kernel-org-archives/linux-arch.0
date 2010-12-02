From: Tony Luck <tony.luck@gmail.com>
Subject: Re: [RFC] persistent store (version 2) (part 1 of 2)
Date: Thu, 2 Dec 2010 10:45:26 -0800
Message-ID: <AANLkTinUY3f=ccaLfZB3rToxHaAKTtHK7W=zeWuGek_F@mail.gmail.com>
References: <4cf594e21679631af0@agluck-desktop.sc.intel.com>
	<20101201165139.a3bb2199.akpm@linux-foundation.org>
	<987664A83D2D224EAE907B061CE93D530191F27E0E@orsmsx505.amr.corp.intel.com>
	<20101202021216.2d7c33f8.akpm@linux-foundation.org>
	<AANLkTimPpEyPMVry5jyhOUe=oByp20TGJHk9s0Kz_Pqf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTimPpEyPMVry5jyhOUe=oByp20TGJHk9s0Kz_Pqf@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@elte.hu" <mingo@elte.hu>, "greg@kroah.com" <greg@kroah.com>, "Huang, Ying" <ying.huang@intel.com>, Borislav Petkov <bp@alien8.de>, David Miller <davem@davemloft.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jim Keniston <jkenisto@linux.vnet.ibm.com>, Kyungmin Park <kmpark@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Dec 2, 2010 at 8:19 AM, Tony Luck <tony.luck@intel.com> wrote:
> was being used? But even then, the user interface wouldn't change
> we could just have each device register a string to be included in
> the filename. Users could look at it if they cared, or ignore it if
> they don't care. The "type" of the data should stay at the front
> of the name so userspace can do "for f in dmesg*" to look at
> al the saved console logs, and it wouldn't matter if the files were
> "dmesg-0", "dmesg-1" or "dmesg-erst-0", "dmesg-erst-1". I
> can't quite see why anyone would care which device was used,
> but the option to provide it would be there without breaking
> apps that used the v1 interface.

Hmmm I may throw the devicename into the filename anyway ... I
still can't see why anyone would care where it came from, but doing
this would allow for consistent filenames across reboots.  My old
code just stuck sequential numbers on the end of the filenames to
make sure it didn't get collisions.  But this means that someone
might be looking at /dev/pstore/dmesg-1 when the system panics.
After the reboot they see two files: the old one and a new one. But
the old code didn't guarantee that the old one would still be "dmesg-1",
it might be "dmesg-2" and "dmesg-1" might now have the latest panic
(ordering is at the whim of the underlying storage, and if it operates in
a LIFO way this could happen).

If I name the file "dmesg-{storename}-{recordid}" then unerased
entries will get the same name next time - which may avoid some
confusion.

-Tony
