From: Michal Marek <mmarek@suse.com>
Subject: Re: [PATCH 2/2] kbuild: modversions for exported asm symbols
Date: Tue, 1 Nov 2016 15:44:17 +0100
Message-ID: <195f928c-3d69-1c05-fe82-85e445f7d48c@suse.com>
References: <20161015124352.10795-1-npiggin@gmail.com>
 <7315031.MmlhY1rulM@wuerfel> <20161020145827.453025a6@roar.ozlabs.ibm.com>
 <16513464.3RM484EDf1@wuerfel> <c9adb10a-1c5f-1b90-ead3-37c6665a903b@suse.com>
 <20161031221445.34e50e69@roar.ozlabs.ibm.com>
 <bd7b413a-3290-b9cc-35c2-09b22bc2ef71@suse.com>
 <20161102013633.5b437f36@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20161102013633.5b437f36@roar.ozlabs.ibm.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

On 2016-11-01 15:36, Nicholas Piggin wrote:
> On Tue, 1 Nov 2016 15:19:59 +0100
> Michal Marek <mmarek@suse.com> wrote:
> 
>> On 2016-10-31 12:14, Nicholas Piggin wrote:
>>> +# This is convoluted. The .S file must first be preprocessed to run guards and
>>> +# expand names, then the resulting exports must be constructed into plain
>>> +# EXPORT_SYMBOL(symbol); to build our dummy C file, and that gets preprocessed
>>> +# to make the genksyms input.
>>>  #
>>>  # These mirror gensymtypes_c and co above, keep them in synch.
>>>  cmd_gensymtypes_S =                                                         \
>>>      (echo "\#include <linux/kernel.h>" ;                                    \
>>>       echo "\#include <asm/asm-prototypes.h>" ;                              \
>>> -     grep EXPORT_SYMBOL $< | sed 's/$$/;/' ) |                              \
>>> +    $(CPP) $(a_flags) $< |                                                  \
>>> +     grep ^___EXPORT_SYMBOL |                                               \
>>> +     sed 's/___EXPORT_SYMBOL \([a-zA-Z0-9_]*\),.*/EXPORT_SYMBOL(\1);/' ) |  \  
>>
>> Is this sed pass necessary? Just add -D__GENKSYMS__ also to the first
>> cpp run and EXPORT_SYMBOL will stay intact.
> 
> I can't see how it would work if asm-generic/export.h doesn't have any
> tests for GENKSYMS.

You are right, these would have to be added first to mimic the
<linux/export.h> behavior.

Michal
