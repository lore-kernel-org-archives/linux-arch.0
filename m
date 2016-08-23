From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] ARC: uaccess: get_user to zero out dest in cause of fault
Date: Mon, 22 Aug 2016 17:09:10 -0700
Message-ID: <365D9EA9-67B4-47E1-8BD3-1C0095F717DA@zytor.com>
References: <CA+55aFzKkVDuizFBH66s8n0u=1FRSXGPNKun9G8rFHaXw5Lx4w@mail.gmail.com> <20F4A326-4107-452C-AF84-385136D9501F@zytor.com> <CA+55aFzsk220hcPXpdsDN_jWhYHqf-zkyN=BxmvfK9q_jp6W4A@mail.gmail.com> <20160822.165710.1114970253560467646.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:38154 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753091AbcHWAJV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Aug 2016 20:09:21 -0400
In-Reply-To: <20160822.165710.1114970253560467646.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>, torvalds@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, jakub@redhat.com, Vineet.Gupta1@synopsys.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com

On August 22, 2016 4:57:10 PM PDT, David Miller <davem@davemloft.net> wrote:
>From: Linus Torvalds <torvalds@linux-foundation.org>
>Date: Mon, 22 Aug 2016 16:48:00 -0700
>
>> How new is it? The whole point was that we'd not have to worry and
>> wait for gcc features..
>
>It's been around for a long time.
>
>I'd say at least gcc-3.0 and later support it.

I think on some architectures it simply calls the library function, but that's okay.
-- 
Sent from my Android device with K-9 Mail. Please excuse brevity and formatting.
