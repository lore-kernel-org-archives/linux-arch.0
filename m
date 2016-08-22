From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] ARC: uaccess: get_user to zero out dest in cause of fault
Date: Mon, 22 Aug 2016 16:51:28 -0700
Message-ID: <6A9009F1-3024-4644-BCF3-31C72ECC1AF7@zytor.com>
References: <1471633802-2936-1-git-send-email-vgupta@synopsys.com> <20160819212428.GR2356@ZenIV.linux.org.uk> <CA+55aFyvBd+sMTC-NsEG4QzVApmy0UhSfpoVOP58m-Zg2wumPQ@mail.gmail.com> <CA+55aFyB_r5KMJrYMygdkFw-UdxFUCExQJDL-d2Cd+Sk2+xLrw@mail.gmail.com> <CA+55aFx9ih9WX-8iUM95fvbuFJ8hf-dK6vwKsVZPh=fdcSB8Cg@mail.gmail.com> <20160821001141.GV2356@ZenIV.linux.org.uk> <CA+55aFyYOZ2U=Fb=oGrVzqvKUprFOAdL8Ra7sTw5KhgibvN0pA@mail.gmail.com> <20160821045402.GC14857@tucnak.redhat.com> <20160821064229.GX2356@ZenIV.linux.org.uk> <CA+55aFxq=KPcS2ZOV51XP3eQNuaiWdJv579NRR+QFSx2sRq5Ww@mail.gmail.com> <CA+55aFzKkVDuizFBH66s8n0u=1FRSXGPNKun9G8rFHaXw5Lx4w@mail.gmail.com> <20F4A326-4107-452C-AF84-385136D9501F@zytor.com> <CA+55aFzsk220hcPXpdsDN_jWhYHqf-zkyN=BxmvfK9q_jp6W4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:37700 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751980AbcHVXvi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Aug 2016 19:51:38 -0400
In-Reply-To: <CA+55aFzsk220hcPXpdsDN_jWhYHqf-zkyN=BxmvfK9q_jp6W4A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jakub Jelinek <jakub@redhat.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>

On August 22, 2016 4:48:00 PM PDT, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>On Mon, Aug 22, 2016 at 4:12 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>>
>> How about the gcc native __builtin_setjmp stuff which is supposedly
>better?
>
>How new is it? The whole point was that we'd not have to worry and
>wait for gcc features..
>
>glibc doesn't use it, which worries me a bit. Has it ever gotten any
>use/testing?
>
>But yes, the compiler could do better. If we can rely on it, and it
>doesn't do stupid things (like have signal state etc crap - glibc
>seems to just alias "setjmp" to "sigsetjmp" with a "didn't save
>signals" flag)
>
>             Linus

We can always fall back on the classic implementation for older gcc, just like we do for so many other features.
-- 
Sent from my Android device with K-9 Mail. Please excuse brevity and formatting.
