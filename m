From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 00/21] of: prom.h clean-up and removal
Date: Thu, 3 Oct 2013 13:08:00 -0500
Message-ID: <CAL_JsqJZTJwMM=noq7dDz5nhMcBGxiHgCEqxwN9BaqwZbXtbmA@mail.gmail.com>
References: <1380221456-11192-1-git-send-email-robherring2@gmail.com>
	<C2D7FE5348E1B147BCA15975FBA2307514EA98@IN01WEMBXA.internal.synopsys.com>
	<C2D7FE5348E1B147BCA15975FBA2307514F2CE@IN01WEMBXA.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307514F2CE-uUKrqVzojAgF5QVroWrzJvufCSb+aD3WLzEdoUbNIic@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Oct 3, 2013 at 4:33 AM, Vineet Gupta <Vineet.Gupta1-HKixBCOQz3jQFizaE/u3fw@public.gmane.org=
m> wrote:
> [Trimmed CC list a bit]
>
> On 09/27/2013 10:26 AM, Vineet Gupta wrote:
>> On 09/27/2013 12:21 AM, Rob Herring wrote:
>>> From: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
>>>
>>> This is the second series of clean-up for architecture DT code. The=
 first
>>> series is here [1].
>>>
>>> As the number of DT enabled architectures has grown, there has been=
 a lot
>>> of copy/paste duplication of prom.h. The include ordering for prom.=
h is
>>> complex and has resulted in many implicit includes. This series cle=
ans up
>>> prom.h and removes the dependency of prom.h includes in the core DT=
 code
>>> on all architectures except sparc. This removes prom.h on several
>>> architectures and makes it an architecture specific include on the =
rest.
>>>
>>> Compiled on arm, arm64, microblaze, mips, openrisc, powerpc, sparc,
>>> xtensa. Mostly defconfigs and some allyesconfigs. The 0-day builder=
 has
>>> also caught some issues.
>>>
>>> A branch with both series is available here:
>>> git://sources.calxeda.com/kernel/linux.git dt-cleanup
>>>
>> I gave the latest branch a spin - everything looks good except for a=
 build warning
>> - and given the const qualifier in the API, I reckon most (if not al=
l) would see that.
>>
>> It seems this was introduced in first series but maybe I failed to n=
otice then as
>> I'm sure I booted that code too.
>>
>> ------------------>8-----------------------------
>>   CC      arch/arc/kernel/devtree.o
>> arch/arc/kernel/devtree.c: In function =91setup_machine_fdt=92:
>> arch/arc/kernel/devtree.c:50:8: warning: assignment discards =91cons=
t=92 qualifier
>> from pointer target type [enabled by default]
>>   mdesc =3D of_flat_dt_match_machine(NULL, arch_get_next_mach);
>>         ^
>> ------------------>8-----------------------------
>>
>> ARM propagates the const to callers - upto setup_arch(), but that mi=
ght not work
>> for us as we use it to setup a global @machine_desc which is then us=
ed to dispatch
>> the callbacks in platform APIs. Semantically it's good if it is cons=
t but that
>> would require making it local and propagating to all the users - not=
 worth the
>> trouble I suppose.
>>
>> What say you !
>
> Ping ?

I think this should be const like arm recently fixed. The structure is
declared const with MACHINE_START which gets dropped.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
