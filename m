From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 26/26] x86/mm: allow to have userspace mappings above 47-bits
Date: Mon, 20 Mar 2017 20:15:50 +1100
Message-ID: <87inn448c9.fsf@concordia.ellerman.id.au>
References: <20170313055020.69655-1-kirill.shutemov@linux.intel.com> <20170313055020.69655-27-kirill.shutemov@linux.intel.com> <87a88jg571.fsf@skywalker.in.ibm.com> <20170317175714.3bvpdylaaudf4ig2@node.shutemov.name> <877f3lfzdo.fsf@skywalker.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <877f3lfzdo.fsf@skywalker.in.ibm.com>
Sender: owner-linux-mm@kvack.org
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
> "Kirill A. Shutemov" <kirill@shutemov.name> writes:
>> On Fri, Mar 17, 2017 at 11:23:54PM +0530, Aneesh Kumar K.V wrote:
>>> So if I have done a successful mmap which returned > 128TB what should a
>>> following mmap(0,...) return ? Should that now search the *full* address
>>> space or below 128TB ?
>>
>> No, I don't think so. And this implementation doesn't do this.
>>
>> It's safer this way: if an library can't handle high addresses, it's
>> better not to switch it automagically to full address space if other part
>> of the process requested high address.
>
> What is the epectation when the hint addr is below 128TB but addr + len >
> 128TB ? Should such mmap request fail ?

Yeah I think that makes sense, it retains the existing behaviour unless
the hint itself is >= 128TB.

cheers

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
