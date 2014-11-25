From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCHv2 02/10] kernel: Provide READ_ONCE and ASSIGN_ONCE
Date: Tue, 25 Nov 2014 09:28:33 -0800
Message-ID: <CA+55aFzY_LSLM8R2cbt=sZe8UeDtUZdX8zO6Bzf52EBg3H30qw@mail.gmail.com>
References: <1416919117-50652-1-git-send-email-borntraeger@de.ibm.com>
	<1416919117-50652-3-git-send-email-borntraeger@de.ibm.com>
	<20141125155943.GB5050@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141125155943.GB5050@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, David Howells <dhowells@redhat.com>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

On Tue, Nov 25, 2014 at 7:59 AM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
>
> We really need something like this to catch invalid sizes:
>
>         default: invoke_nonexistent_function();

Actually, I wonder if we should make the default: case actually just
do something like

   barrier();
   memcpy(res, p, size);
   barrier();

which in no way guarantees that it's an _atomic_ access, but it does
guarantee the semantics that you get one particular value and it won't
get reloaded later..

That would solve the crazy sparc pte issue too.


               Linus
