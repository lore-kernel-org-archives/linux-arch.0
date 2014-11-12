From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: compiler bug gcc4.6/4.7 with ACCESS_ONCE and workarounds
Date: Tue, 11 Nov 2014 16:33:49 -0800
Message-ID: <CA+55aFz1oxCgZiY4oWu41fFUbKft9g5_gQXXzAKuW8+pnR72Vw@mail.gmail.com>
References: <1415360716-9670-2-git-send-email-borntraeger@de.ibm.com>
	<54611D86.4040306@de.ibm.com>
	<CA+55aFyEigSL64RJH8AO86gFBBB84+dgk7eEUPx=CaLwJMcO_w@mail.gmail.com>
	<54627CBF.2000704@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54627CBF.2000704@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andreas Krebbel <Andreas.Krebbel@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Nov 11, 2014 at 1:16 PM, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
> Are you ok with the patch as is in kvm/next for the time being or shall
> we revert that and replace it with the .val scheme?

Is that the one that was quoted at the beginning of the thread, that
uses barrier()?

I guess as a workaround it is fine, as long as we don't lose sight of
trying to eventually do a better job.

                     Linus
