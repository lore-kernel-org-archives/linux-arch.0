From: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v7 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.rst
Date: Thu, 8 Aug 2019 09:25:47 +0000
Message-ID: <48c5f9b3-d253-bede-e755-0aabba2757b5@arm.com>
References: <20190807155321.9648-1-catalin.marinas@arm.com>
 <20190807155321.9648-2-catalin.marinas@arm.com>
 <826a9ace-feac-c019-843e-07e23c9fd46c@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <826a9ace-feac-c019-843e-07e23c9fd46c@intel.com>
Content-Language: en-US
Content-ID: <960F9790878B3346A988307D90E92E55@eurprd08.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Hansen <dave.hansen@intel.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Vincenzo Frascino <Vincenzo.Frascino@arm.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Andrey Konovalov <andreyknvl@google.com>, Kevin Brodsky <Kevin.Brodsky@arm.com>, Will Deacon <Will.Deacon@arm.com>, nd <nd@arm.com>
List-Id: linux-arch.vger.kernel.org

On 07/08/2019 21:38, Dave Hansen wrote:
> On 8/7/19 8:53 AM, Catalin Marinas wrote:
>> +- The syscall behaviour is undefined for non valid tagged pointers.
> 
> Do you really mean "undefined"?  I mean, a bad pointer is a bad pointer.
>  Why should it matter if it's a tagged bad pointer or an untagged bad
> pointer?

bad pointers are invalid, but some non-bad pointers are
also invalid if they are tagged (e.g. tagged pointer to
device memory?) those may be valid to dereference in
userspace but don't work across the syscall abi (device
driver does not handle the tag?).

>> +- mmap() addr parameter.
>> +
>> +- mremap() new_address parameter.
> 
> Is munmap() missing?  Or was there a reason for leaving it out?

the new address in mmap and mremap may not be currently
mapped, other m* functions operate on existing mappings
(munmap, madvise, mprotect, mlock,...)

although by this logic brk (and related PR_SET_MM_*)
should be excluded here too.

>> +- prctl(PR_SET_MM, ``*``, ...) other than arg2 PR_SET_MM_MAP and
>> +  PR_SET_MM_MAP_SIZE.
>> +
>> +- prctl(PR_SET_MM, PR_SET_MM_MAP{,_SIZE}, ...) struct prctl_mm_map fields.
>> +
>> +Any attempt to use non-zero tagged pointers will lead to undefined
>> +behaviour.
> 
> I wonder if you want to generalize this a bit.  I think you're saying
> that parts of the ABI that modify the *layout* of the address space
> never accept tagged pointers.

something like that, but i think this is hard to specify
in a generic way.
