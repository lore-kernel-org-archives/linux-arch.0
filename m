From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: Question on the five-level page table support patches
Date: Mon, 24 Apr 2017 22:37:40 +0200
Message-ID: <fdc80e3c-6909-cf39-fe0b-6f1c012571e4@physik.fu-berlin.de>
References: <030ea57b-5f6c-13d8-02f7-b245a754a87d@physik.fu-berlin.de>
 <20170424161959.c5ba2nhnxyy57wxe@node.shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170424161959.c5ba2nhnxyy57wxe@node.shutemov.name>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

On 04/24/2017 06:19 PM, Kirill A. Shutemov wrote:
> In proposed implementation, we also use hint address, but in different
> way: by default, if hint address is NULL, kernel would not create mappings
> above 47-bits, preserving compatibility.

Ooooh, that would solve a lot of problems actually if it were to be available
on all architectures. On SPARC, the situation is really annoying and I have
been discussing a solution with the Qt developers and they suggested a
similar approach, just one that would also apply to brk() [1].

> If an application wants to have access to larger address space, it has to
> specify hint addess above 47-bits.
> 
> See details here:
> 
> http://lkml.kernel.org/r/20170420162147.86517-10-kirill.shutemov@linux.intel.com

Thanks. I'll have a read. Although from your message I'm reading out that
this particular proposal got rejected.

Would be really nice to able to have a canonical solution for this issue,
it's been biting us on SPARC for quite a while now due to the fact that
virtual address space has been 52 bits on SPARC for a while now.

Adrian

> [1] https://bugreports.qt.io/browse/QTBUG-56264

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
