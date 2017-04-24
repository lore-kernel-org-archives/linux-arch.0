From: Andy Lutomirski <luto@kernel.org>
Subject: Re: Question on the five-level page table support patches
Date: Sun, 23 Apr 2017 22:11:08 -0700
Message-ID: <CALCETrUcB7STNjVw=WBZdFfz_H1DKcLnj3HHtnGaHGQ1UY8Zrw@mail.gmail.com>
References: <030ea57b-5f6c-13d8-02f7-b245a754a87d@physik.fu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <030ea57b-5f6c-13d8-02f7-b245a754a87d@physik.fu-berlin.de>
Sender: owner-linux-mm@kvack.org
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>, linux-arch <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
List-Id: linux-arch.vger.kernel.org

On Sun, Apr 23, 2017 at 3:53 AM, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> Hi Kirill!
>
> I recently read the LWN article on your and your colleagues work to
> add five-level page table support for x86 to the Linux kernel [1]
> and I got your email address from the last patch of the series.
>
> Since this extends the address space beyond 48-bits, as you may know,
> it will cause potential headaches with Javascript engines which use
> tagged pointers. On SPARC, the virtual address space already extends
> to 52 bits and we are running into these very issues with Javascript
> engines on SPARC.
>
> Now, a possible way to mitigate this problem would be to pass the
> "hint" parameter to mmap() in order to tell the kernel not to allocate
> memory beyond the 48 bits address space. Unfortunately, on Linux this
> will only work when the area pointed to by "hint" is unallocated which
> means one cannot simply use a hardcoded "hint" to mitigate this problem.
>
> However, since this trick still works on NetBSD and used to work on
> Linux [3], I was wondering whether there are plans to bring back
> this behavior to mmap() in Linux.
>
> Currently, people are using ugly work-arounds [4] to address this
> problem which involve a manual iteration over memory blocks and
> basically implementing another allocator in the user space
> application.
>
> Thanks,
> Adrian
>
>> [1] https://lwn.net/Articles/717293/
>> [2] https://lwn.net/Articles/717300/
>> [3] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D824449#22
>> [4] https://hg.mozilla.org/mozilla-central/rev/dfaafbaaa291
>

Can you explain what the issue is?  What used to work on Linux and
doesn't any more?  The man page is quite clear:

       MAP_FIXED
              Don't  interpret  addr  as  a hint: place the mapping at exac=
tly
              that address.  addr must be a multiple of the page size.  If =
the
              memory  region  specified  by addr and len overlaps pages of =
any
              existing mapping(s), then the overlapped part  of  the  exist=
ing
              mapping(s)  will  be discarded.  If the specified address can=
not
              be used, mmap() will fail.  Because requiring  a  fixed  addr=
ess
              for  a  mapping is less portable, the use of this option is d=
is=E2=80=90
              couraged.

and AFAIK Linux works exactly as documented.

FWIW, a patch to add a new MAP_ mode to tell mmap(2) to use the hinted
address if available and to *fail* if the hinted address is not
available would very likely be accepted and would IMO be much nicer
than the current behavior.

--Andy

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
