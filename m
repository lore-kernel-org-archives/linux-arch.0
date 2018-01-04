From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Date: Thu, 4 Jan 2018 15:12:00 -0800
Message-ID: <CAPcyv4gVq=F-+8YX6ALUiL61MtOVtDzPrEo18WVsFodZ1YY20A@mail.gmail.com>
References: <20180103223827.39601-1-mark.rutland@arm.com> <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
 <20180104010754.22ca6a74@alans-desktop> <CAPcyv4ge14OPyfoQvXHLyXwqX7cjWvm4DouUOc=WrNo1Lr9Qyw@mail.gmail.com>
 <alpine.DEB.2.20.1801040728140.2148@hadrien> <CAPcyv4gLcC7vsxLUCEJdEvDRf4AhgF0x1fpTEcH7AOe=kuNfoQ@mail.gmail.com>
 <20180104192648.GA10427@amd> <CAPcyv4g0ZEP_LuXwsf1rJGaG65UHn5sj=DMyMdCnzKD9T-vnyg@mail.gmail.com>
 <20180104224455.GA22369@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180104224455.GA22369@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Jan 4, 2018 at 2:44 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> >> > What should one be looking for.  Do you have a typical example?
>> >> >
>> >>
>> >> See "Exploiting Conditional Branch Misprediction" from the paper [1].
>> >>
>> >> The typical example is an attacker controlled index used to trigger a
>> >> dependent read near a branch. Where an example of "near" from the
>> >> paper is "up to 188 simple instructions inserted in the source code
>> >> between the =E2=80=98if=E2=80=99 statement and the line accessing arr=
ay...".
>> >>
>> >> if (attacker_controlled_index < bound)
>> >>      val =3D array[attacker_controlled_index];
>> >> else
>> >>     return error;
>> >>
>> >> ...when the cpu speculates that the 'index < bound' branch is taken i=
t
>> >> reads index and uses that value to read array[index]. The result of a=
n
>> >> 'array' relative read is potentially observable in the cache.
>> >
>> > You still need
>> >
>> >         (void) array2[val];
>> >
>> > after that to get something observable, right?
>>
>> As far as I understand the presence of array2[val] discloses more
>> information, but in terms of the cpu taking an action that it is
>> observable in the cache that's already occurred when "val =3D
>> array[attacker_controlled_index];" is speculated. Lets err on the
>
> Well yes, attacker can observe val =3D
> array[attacker_controlled_index]; . But that's not something he's
> interested in. So the CPU cheats and attacker has a proof. But he knew
> that before.
>
>>side
>> of caution and shut down all the observable actions that are already
>> explicitly gated by an input validation check. In other words, a low
>> bandwidth information leak is still a leak.
>
> What did it leak? Nothing. Attacker had to know
> array+attacker_controlled_index, and he now knows
> (array+attacker_controlled_index)%CACHELINE_SIZE.
>
> With (void) array2[val];, the attack gets interesting -- I now know
> *(array+attacker_controlled_index) % CACHELINE_SIZE ... allowing me to
> get information from arbitrary place in memory -- which is useful for
> .. reading ssh keys, for example.

Right, but how far away from "val =3D array[attacker_controlled_index];"
in the instruction stream do you need to look before you're
comfortable there's no 'val' dependent reads in the speculation window
on all possible architectures. Until we have variable annotations and
compiler help my guess is that static analysis has an easier time
pointing us to the first potentially bad speculative access.
