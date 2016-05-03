From: "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [RFC v2 3/7] firmware: port built-in section to linker table
Date: Tue, 3 May 2016 10:08:53 -0700
Message-ID: <CAB=NE6XNt8Dwu5Kp=yt0cankemE_5Es1SdwmFo+q5-N466F3Ww@mail.gmail.com>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
 <1455889559-9428-4-git-send-email-mcgrof@kernel.org> <1456740770.4666.366.camel@infradead.org>
 <20160229185606.GD25240@wotan.suse.de> <CAGXu5jKkKvA5zWmr+U0TYKBBFgDL62xzQwWDOFGQMkmwKXMaMQ@mail.gmail.com>
 <20160502184106.GA17329@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160502184106.GA17329@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>, David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Rusty Russell <rusty@rustcorp.com.au>, David Vrabel <david.vrabel@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Michael Brown <mcb30@ipxe.org>, Juergen Gross <jgross@suse.com>, Ming Lei <ming.lei@canonical.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, jbaron@akamai.com, "ananth@in.ibm.com" <ananth@in.ibm.com>, anil.s.keshavamurthy@intel.com, David S. M
List-Id: linux-arch.vger.kernel.org

On Mon, May 2, 2016 at 11:41 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Mon, May 02, 2016 at 11:34:33AM -0700, Kees Cook wrote:
>> On Mon, Feb 29, 2016 at 10:56 AM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
>> > On Mon, Feb 29, 2016 at 10:12:50AM +0000, David Woodhouse wrote:
>> >> On Fri, 2016-02-19 at 05:45 -0800, Luis R. Rodriguez wrote:
>> >> > This ports built-in firmware to use linker tables,
>> >> > this replaces the custom section solution with a
>> >> > generic solution.
>> >> >
>> >> > This also demos the use of the .rodata (SECTION_RO)
>> >> > linker tables.
>> >> >
>> >> > Tested with 0 built-in firmware, 1 and 2 built-in
>> >> > firmwares successfully.
>> >>
>> >> I think we'd do better to rip this support out entirely. It just isn't
>> >> needed; firmware can live in an initramfs and don't even need *any*
>> >> actual running userspace support to load it from there these days, do
>> >> we?
>> >
>> > I think this is reasonable if and only if we really don't know of anyone
>> > out there not able to use initramfs. I'm happy to rip it out.
>>
>> The changelog for this doesn't say anything about _why_ the change is
>> being made? (and what about other architectures.) Also, Chrome OS
>> doesn't use an initramfs (and plenty of other things don't too). Being
>> able to build monolithic kernels (e.g. Android and Brillo) with
>> builtin firmware is very handy. Please don't remove built-in firmware
>> support.
>
> I second this, we can't break existing systems at all.  I thought we
> were going to keep built-in firmware, right Luis?

Removing built-in firmware was simply a suggestion by David which we
were evaluating here -- patches were not even yet produced, although I
have them now if we wanted to rip it out. Since Kees noted it has
users, we'll keep it.

 Luis
