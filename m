From: Hannes Frederic Sowa <hannes@redhat.com>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from
 asm
Date: Thu, 15 Dec 2016 16:17:45 +0100
Message-ID: <d098b437-7072-6199-f183-9ee9d01bdc8e@redhat.com>
References: <20161201051852.28dc335f@roar.ozlabs.ibm.com>
 <CA+55aFzMTrLMrr69ipdaKhz+RJhUu3BxB+kg0689qq_470qEcw@mail.gmail.com>
 <20161201041325.GX35881@redhat.com>
 <20161201153215.43b6cec7@roar.ozlabs.ibm.com>
 <20161201152039.GB35881@redhat.com>
 <20161209135041.5ff12770@roar.ozlabs.ibm.com>
 <0937c184-1946-c494-56b6-c38fd0b632c2@redhat.com>
 <20161209181459.1f0a4fed@roar.ozlabs.ibm.com>
 <249321c0-bcb1-f9d8-50f4-c083b656d02e@redhat.com>
 <20161210015653.5b0dc872@roar.ozlabs.ibm.com>
 <20161209160337.GA3061@kroah.com>
 <27aafb3b-adb2-47b8-7964-6e36fcb57676@redhat.com>
 <20161215120615.34fd0f22@roar.ozlabs.ibm.com>
 <a7e04d09-121c-df8c-9b4c-fedc7869c465@redhat.com>
 <20161215220322.63e72ff5@roar.ozlabs.ibm.com>
 <027b6dd6-2117-2ff9-7308-e0b235bbd1d7@redhat.com>
 <20161216001512.78910281@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161216001512.78910281@roar.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stanislav Kozina <skozina@redhat.com>, Don Zickus <dzickus@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>
List-Id: linux-arch.vger.kernel.org

On 15.12.2016 15:15, Nicholas Piggin wrote:
> On Thu, 15 Dec 2016 14:15:31 +0100
> Hannes Frederic Sowa <hannes@redhat.com> wrote:
> 
>> On 15.12.2016 13:03, Nicholas Piggin wrote:
>>> On Thu, 15 Dec 2016 12:19:02 +0100
>>> Hannes Frederic Sowa <hannes@redhat.com> wrote:
>>>   
>>>> On 15.12.2016 03:06, Nicholas Piggin wrote:  
>>>>> On Wed, 14 Dec 2016 15:04:36 +0100
>>>>> Hannes Frederic Sowa <hannes@redhat.com> wrote:
>>>>>     
>>>>>> On 09.12.2016 17:03, Greg Kroah-Hartman wrote:    
>>>>>>> On Sat, Dec 10, 2016 at 01:56:53AM +1000, Nicholas Piggin wrote:      
>>>>>>>> On Fri, 9 Dec 2016 15:36:04 +0100
>>>>>>>> Stanislav Kozina <skozina@redhat.com> wrote:
>>>>>>>>      
>>>>>>>>>>>>> The question is how to provide a similar guarantee if a different way?        
>>>>>>>>>>>> As a tool to aid distro reviewers, modversions has some value, but the
>>>>>>>>>>>> debug info parsing tools that have been mentioned in this thread seem
>>>>>>>>>>>> superior (not that I've tested them).        
>>>>>>>>>>> On the other hand the big advantage of modversions is that it also
>>>>>>>>>>> verifies the checksum during runtime (module loading). In other words, I
>>>>>>>>>>> believe that any other solution should still generate some form of
>>>>>>>>>>> checksum/watermark which can be easily checked for compatibility on
>>>>>>>>>>> module load.
>>>>>>>>>>> It should not be hard to add to the DWARF based tools though. We'd just
>>>>>>>>>>> parse DWARF data instead of the C code.        
>>>>>>>>>> A runtime check is still done, with per-module vermagic which distros
>>>>>>>>>> can change when they bump the ABI version. Is it really necessary to
>>>>>>>>>> have more than that (i.e., per-symbol versioning)?        
>>>>>>>>>
>>>>>>>>>  From my point of view, it is. We need to allow changing ABI for some 
>>>>>>>>> modules while maintaining it for others.
>>>>>>>>> In fact I think that there should be version not only for every exported 
>>>>>>>>> symbol (in the EXPORT_SYMBOL() sense), but also for every public type 
>>>>>>>>> (in the sense of eg. structure defined in the public header file).      
>>>>>>>>
>>>>>>>> Well the distro can just append _v2, _v3 to the name of the function
>>>>>>>> or type if it has to break compat for some reason. Would that be enough?      
>>>>>>>
>>>>>>> There are other ways that distros can work around when upstream "breaks"
>>>>>>> the ABI, sometimes they can rename functions, and others they can
>>>>>>> "preload" structures with padding in anticipation for when/if fields get
>>>>>>> added to them.  But that's all up to the distros, no need for us to
>>>>>>> worry about that at all :)      
>>>>>>
>>>>>> The _v2 and _v3 functions are probably the ones that also get used by
>>>>>> future backports in the distro kernel itself and are probably the reason
>>>>>> for the ABI change in the first place. Thus going down this route will
>>>>>> basically require distros to touch every future backport patch and will
>>>>>> in general generate a big mess internally.    
>>>>>
>>>>> What kind of big mess? You have to check the logic of each backport even
>>>>> if it does apply cleanly, so the added overhead of the name change should
>>>>> be relatively tiny, no?    
>>>>
>>>> Basically single patches are backported in huge series. Reviewing each
>>>> single patch also definitely makes sense, a review of the series as a
>>>> whole is much more worthwhile because it focuses more on logic.
>>>>
>>>> The patches themselves are checked by individual robots or humans
>>>> against merge conflict introduced mistakes which ring alarm bells for
>>>> people to look more closely during review.
>>>>
>>>> Merge conflicts introduced mistakes definitely can happen because
>>>> developers/backporters lose the focus from the actual logic but deal
>>>> with shifting lines around or just fixing up postfixes to function names.
>>>>
>>>> We still try to align the kernel as much as possible with upstream,
>>>> because most developers can't really hold the differences between
>>>> upstream and the internal functions in their heads (is this function RMW
>>>> safe in this version but not that kernel version...).  
>>>
>>> I agree with all this, but in the case of a function rename, you can
>>> automate it all with scripts if that's what you want.
>>>
>>> When you have your list of exported symbols with non-zero version number,
>>> then you can script that __abivXXX into the changeset applying process,
>>> or alternatively apply the rename after your patches are applied, or
>>> use the c preprocessor to define names to something else.  
>>
>> Yes, probably one could come up with coccinelle patches to do this,
>> preprocessing/string matching could have false positives. But as I wrote
>> above, we need one stable ABI and not multiple for our particular
>> kernels, so it seems like a lot of overhead to rename particular
>> functions internally all the time to make them inaccessible for external
>> modules.
> 
> I can't be sure until it's implemented in a workflow that distros are
> happy with of course, but I just don't see why it would be a lot of
> overhead. Particularly if you just scripted everything.

Yes, me neither, of course. I just would favor to get away with the
scripting if possible. ;)

> How frequently do symbols become incompatible within an ostensibly ABI-
> stable release?

Given how genksyms works right now, I would say quite frequently. I
would even go that far to say that every larger backport I had to deal
with in networking had those problems because of some very important top
level structs that make everything reachable (struct net_device or
struct sock), so each change to those structs basically cause a kabi change.

Even if we replace padding in a structure we added before a release,
this is actually considered a kabi breakage, we must annotate this
appropriately because of genksyms.

E.g. I also thought about reordering the structs. As already discussed
in this thread, genksyms takes ordering of its definition vs.
declarations into account, e.g.:

struct foo;
struct bar {
	struct foo *f;
};
<< private >>
struct foo {
};

wouldn't actually include struct foo as part of the symvers, but the
other way around it would.

Instead of burden upstream with this kind of reordering, a suppression
engine would be favored by me which we can drive by review and
discussions. Thus upstream doesn't have any burden on that, but it is
solely the burden of the distributions, where the burden belongs. ;)

>>>> Like Don also already said, genksyms already did a pretty good job so
>>>> far. We are right now working with Dodji to come up with a way to
>>>> replace genksyms, in case people really want to have very specific
>>>> control about what causes the symbol version to be changed.  
>>>
>>> Yeah it's great work, so is Stanislav's checker. I wouldn't mind having
>>> a kernel-centric checker tool merged in the kernel if it is small,
>>> maintained, and does a sufficient job for distros.  
>>
>> Yes, I think this needs more experimentation and thought right now
>> before we can make a decision.
> 
> Sure, I wanted to mention it in case people had a concern about out
> of tree tools. It will depend on what distros end up settling with.

The possibilities I see right now:

* we leave genksyms where it is for the time being and add a KCONFIG
knob to be able to call a replacement tool with well formed command line
syntax and stdout semantics.

* we import one of the alternatives instead of genksyms if it fits to
the kernel. I am still a bit concerned about differences in dwarf vs.
source code parsing. In the past I had twice bugs in dwarf generation,
but this probably can be dealt with, but just needs a bit more
experience in my opinion.

* we remove genksyms and just use one versioning vector for upstream but
still allow some kind of modversions per symbol being loaded from a
third party program like kabi-dw or libabigail.

Personally, because I see genksyms working quite well right now, I would
stick to it until we (the distributions) came to a conclusion.

Bye,
Hannes
