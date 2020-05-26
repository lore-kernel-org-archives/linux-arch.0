From: Akira Yokosawa <akiyks@gmail.com>
Subject: Re: Some -serious- BPF-related litmus tests
Date: Tue, 26 May 2020 23:02:48 +0900
Message-ID: <b92f9c0a-826c-d074-5389-8c340f7cccf2@gmail.com>
References: <20200522003850.GA32698@paulmck-ThinkPad-P72>
 <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522143201.GB32434@rowland.harvard.edu>
 <20200522174352.GJ2869@paulmck-ThinkPad-P72>
 <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com>
 <ac799c98-45dd-d056-386f-cbebc7270c0c@gmail.com>
 <CAEf4BzYGbLfGA=NN=dP1RqDj7yp_Fnu0L-1bgQojPMt0-Y_X=g@mail.gmail.com>
 <69ed3604-4275-d73e-a5d6-2b70dd877104@gmail.com>
 <CAEf4BzajE6jCkbBQ+f0cG=Y+vAEPWGNhfOMFVVhoDZWjNV-oGA@mail.gmail.com>
 <d1113b47-a920-c0e4-9aa4-88781368a26f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729443AbgEZOCz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 May 2020 10:02:55 -0400
In-Reply-To: <d1113b47-a920-c0e4-9aa4-88781368a26f@gmail.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: luc.maranget@inria.fr, Andrii Nakryiko <andriin@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Peter Zijlstra <peterz@infradead.org>, parri.andrea@gmail.com, will@kernel.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, dlustig@nvidia.com, Joel Fernandes <joel@joelfernandes.org>, open list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

On Tue, 26 May 2020 19:50:47 +0900, Akira Yokosawa wrote:
> On Mon, 25 May 2020 16:31:05 -0700, Andrii Nakryiko wrote:
>> On Mon, May 25, 2020 at 3:01 PM Akira Yokosawa <akiyks@gmail.com> wrot=
e:
>>>
> [...]
>>> Yes, that should work.
>>
>> Ok, assigning to zero didn't work (it still complained about
>> uninitialized read), but using a separate int *lenFail to assign to
>> rLenPtr worked. Curiously, if I used rLenPtr =3D len1; in error case, =
it
>> actually takes a bit more time to verify.
>>
>> So I've converted everything else as you suggested. I compiled latest
>> herd7 and it doesn't produce any warnings. But it's also extremely
>> slow, compared to the herd7 that I get by default. Validating simple
>> 1p1c cases takes about 2.5x times longer (0.03s vs 0.07),

Wait a moment!

This 0.03s was the run time of the original 1p1c litmus test, wasn't it?
Then you are comparing apples and oranges.

How long does your default herd7 take to complete the updated 1p1c test?

        Thanks, Akira

>>                                                           but trying
>> to validate 2p1c case, which normally validates in 42s (unbounded) and=

>> 110s (bounded), it took more than 20 minutes and hasn't finished,
>> before I gave up. So I don't know what's going on there...
>=20
> herdtools7 has recently been heavily restructured.
> On the performance regression, I must defer to Luc.
>=20
> Luc, do you have any idea?
>=20
>>
>> As for klitmus7, I managed to generate everything without warnings,
>> but couldn't make it build completely due to:
>>
>> $ make
>> make -C /lib/modules/5.6.13-01802-g938d64da97c6/build/
>=20
> So you are on Linux 5.6.x which requires cutting-edge klitmus7.
>=20
>> M=3D/home/andriin/local/linux-trees/tools/memory-model/mymodules modul=
es
>> make[1]: Entering directory `/data/users/andriin/linux-build/fb-config=
'
>> make[2]: Entering directory `/data/users/andriin/linux-build/default-x=
86_64'
>>   CC [M]  /home/andriin/local/linux-trees/tools/memory-model/mymodules=
/litmus000.o
>> /home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus000=
=2Ec:
>> In function =E2=80=98zyva=E2=80=99:
>> /home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus000=
=2Ec:507:12:
>> warning: ISO C90 forbids variable length array =E2=80=98th=E2=80=99 [-=
Wvla]
>>      struct task_struct *th[nth];
>>             ^~~~~~~~~~~
>> /home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus000=
=2Ec:
>> In function =E2=80=98litmus_init=E2=80=99:
>> /home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus000=
=2Ec:605:67:
>> error: passing argument 4 of =E2=80=98proc_create=E2=80=99 from incomp=
atible pointer
>> type [-Werror=3Dincompatible-pointer-types]
>>    struct proc_dir_entry *litmus_pde =3D
>> proc_create("litmus",0,NULL,&litmus_proc_fops);
>>
>> ^~~~~~~~~~~~~~~~~
>> In file included from
>> /home/andriin/local/linux-trees/tools/memory-model/mymodules/litmus000=
=2Ec:15:
>> /data/users/andriin/linux-fb/include/linux/proc_fs.h:64:24: note:
>> expected =E2=80=98const struct proc_ops *=E2=80=99 but argument is of =
type =E2=80=98const
>> struct file_operations *=E2=80=99
>>  struct proc_dir_entry *proc_create(const char *name, umode_t mode,
>> struct proc_dir_entry *parent, const struct proc_ops *proc_ops);
>>                         ^~~~~~~~~~~
>> cc1: some warnings being treated as errors
>> make[3]: *** [/home/andriin/local/linux-trees/tools/memory-model/mymod=
ules/litmus000.o]
>> Error 1
>> make[2]: *** [/home/andriin/local/linux-trees/tools/memory-model/mymod=
ules]
>> Error 2
>> make[2]: Leaving directory `/data/users/andriin/linux-build/default-x8=
6_64'
>> make[1]: *** [sub-make] Error 2
>> make[1]: Leaving directory `/data/users/andriin/linux-build/fb-config'=

>> make: *** [all] Error 2
>>
>=20
> These errors suggest the klitmus7 you used is version 7.52 or some such=
=2E
> You said you have built herd7 from the source.  Have you also built kli=
tmus7?
>=20
> The up-to-date klitmus7 should generate code compatible with Linux 5.6.=
x.
>=20
> Could you try with the latest one?
>=20
>         Thanks, Akira
>=20
>>
>> But at least it doesn't complain about atomic_t anymore. So anyways,
>> I'm going to post updated litmus tests separately from BPF ringbuf
>> patches, because Documentation/litmus-tests is not yet present in
>> bpf-next.
>>
>>>
>>> You can find a basic introduction of klitmus7 in tools/memory-model/R=
EADME.
>>>
>>>         Thanks, Akira
>>>
>>>>
>>>>>
>>>>> Please note that if you are on Linux 5.6 (or later), you need an up=
-to-date
>>>>> klitmus7 due to a change in kernel API.
>>>>>
>>>>> Any question is welcome!
>>>>>
>>>>>         Thanks, Akira
>>>>>
>>
>> [...]
>>
>=20
