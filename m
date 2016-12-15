From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported
 from asm
Date: Thu, 15 Dec 2016 22:03:22 +1000
Message-ID: <20161215220322.63e72ff5@roar.ozlabs.ibm.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a7e04d09-121c-df8c-9b4c-fedc7869c465@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hannes Frederic Sowa <hannes@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stanislav Kozina <skozina@redhat.com>, Don Zickus <dzickus@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, 15 Dec 2016 12:19:02 +0100
Hannes Frederic Sowa <hannes@redhat.com> wrote:

> On 15.12.2016 03:06, Nicholas Piggin wrote:
> > On Wed, 14 Dec 2016 15:04:36 +0100
> > Hannes Frederic Sowa <hannes@redhat.com> wrote:
> >   
> >> On 09.12.2016 17:03, Greg Kroah-Hartman wrote:  
> >>> On Sat, Dec 10, 2016 at 01:56:53AM +1000, Nicholas Piggin wrote:    
> >>>> On Fri, 9 Dec 2016 15:36:04 +0100
> >>>> Stanislav Kozina <skozina@redhat.com> wrote:
> >>>>    
> >>>>>>>>> The question is how to provide a similar guarantee if a different way?      
> >>>>>>>> As a tool to aid distro reviewers, modversions has some value, but the
> >>>>>>>> debug info parsing tools that have been mentioned in this thread seem
> >>>>>>>> superior (not that I've tested them).      
> >>>>>>> On the other hand the big advantage of modversions is that it also
> >>>>>>> verifies the checksum during runtime (module loading). In other words, I
> >>>>>>> believe that any other solution should still generate some form of
> >>>>>>> checksum/watermark which can be easily checked for compatibility on
> >>>>>>> module load.
> >>>>>>> It should not be hard to add to the DWARF based tools though. We'd just
> >>>>>>> parse DWARF data instead of the C code.      
> >>>>>> A runtime check is still done, with per-module vermagic which distros
> >>>>>> can change when they bump the ABI version. Is it really necessary to
> >>>>>> have more than that (i.e., per-symbol versioning)?      
> >>>>>
> >>>>>  From my point of view, it is. We need to allow changing ABI for some 
> >>>>> modules while maintaining it for others.
> >>>>> In fact I think that there should be version not only for every exported 
> >>>>> symbol (in the EXPORT_SYMBOL() sense), but also for every public type 
> >>>>> (in the sense of eg. structure defined in the public header file).    
> >>>>
> >>>> Well the distro can just append _v2, _v3 to the name of the function
> >>>> or type if it has to break compat for some reason. Would that be enough?    
> >>>
> >>> There are other ways that distros can work around when upstream "breaks"
> >>> the ABI, sometimes they can rename functions, and others they can
> >>> "preload" structures with padding in anticipation for when/if fields get
> >>> added to them.  But that's all up to the distros, no need for us to
> >>> worry about that at all :)    
> >>
> >> The _v2 and _v3 functions are probably the ones that also get used by
> >> future backports in the distro kernel itself and are probably the reason
> >> for the ABI change in the first place. Thus going down this route will
> >> basically require distros to touch every future backport patch and will
> >> in general generate a big mess internally.  
> > 
> > What kind of big mess? You have to check the logic of each backport even
> > if it does apply cleanly, so the added overhead of the name change should
> > be relatively tiny, no?  
> 
> Basically single patches are backported in huge series. Reviewing each
> single patch also definitely makes sense, a review of the series as a
> whole is much more worthwhile because it focuses more on logic.
> 
> The patches themselves are checked by individual robots or humans
> against merge conflict introduced mistakes which ring alarm bells for
> people to look more closely during review.
> 
> Merge conflicts introduced mistakes definitely can happen because
> developers/backporters lose the focus from the actual logic but deal
> with shifting lines around or just fixing up postfixes to function names.
> 
> We still try to align the kernel as much as possible with upstream,
> because most developers can't really hold the differences between
> upstream and the internal functions in their heads (is this function RMW
> safe in this version but not that kernel version...).

I agree with all this, but in the case of a function rename, you can
automate it all with scripts if that's what you want.

When you have your list of exported symbols with non-zero version number,
then you can script that __abivXXX into the changeset applying process,
or alternatively apply the rename after your patches are applied, or
use the c preprocessor to define names to something else.

> 
> Anyway, I don't think we will at any time have multiple versions of a
> function exported to 3rd party kernel modules. The headaches are just
> too big. Basically we would have to version structs and not functions
> (this is our bigger problem), thus exporting new versions of functions
> don't really help at all. Having multiple versions of structs really
> scares me. ;)
> 
> We already pad structs to allow for additional struct members to be
> added, which helps a lot.
> 
> If versioning of function symbols would be an issue we probably would
> have switched to ELF function versioning (like glibc does it) long time ago.
> 
> >> I think it is important to keep versioning information outside of the
> >> source code. Some kind of modversions will still be required, but
> >> distros should be able to decide if they put in some kind of checksum or
> >> a string, what suites them most.  
> > 
> > The module crc symbols are just an integer that requires a match, so it
> > could easily be populated by a list that the distro keeps, rather than
> > by genksyms. Most of the complexity is on the build side, so that would
> > still be an improvement for the kernel. So we *could* do this if the
> > distros need it.  
> 
> Like Don also already said, genksyms already did a pretty good job so
> far. We are right now working with Dodji to come up with a way to
> replace genksyms, in case people really want to have very specific
> control about what causes the symbol version to be changed.

Yeah it's great work, so is Stanislav's checker. I wouldn't mind having
a kernel-centric checker tool merged in the kernel if it is small,
maintained, and does a sufficient job for distros.

> Also I wonder what Ben's opinion on this is.. As I understood that he
> wants to maintain a super-long-term stable kernel with kabi guarantees.
> 
> Note, what we want is to weaken the check for kabi, by excluding parts
> of the struct from genksyms with libabigail. For Red Hat genksyms is too
> strict in the checks.

Sure, that makes sense.

So if I understand where we are, moving the ABI compatibility checking
to one of these tools looks possible. What to do when we have an ABI change
is not settled, but feeding version numbers explicitly into modversions
is an option that would be close to what distros do today.

Thanks,
Nick
