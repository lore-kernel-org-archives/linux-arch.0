From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 01/11] x86: Use asm goto to implement better
 modify_and_test() functions
Date: Thu, 19 Sep 2013 01:31:02 -0700
Message-ID: <20130919083102.GB11427@tassilo.jf.intel.com>
References: <20130917082838.218329307@infradead.org>
 <20130917091143.387880231@infradead.org>
 <CA+55aFyVZNb3ZrLfh5FkV4E_P5_LE4-LpDHBwFNp=W1H7CnSBg@mail.gmail.com>
 <4ec87843-c29a-401a-a54f-2cd4d61fba62@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4ec87843-c29a-401a-a54f-2cd4d61fba62@email.android.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Mike Galbraith <bitbucket@online.de>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 18, 2013 at 02:02:37PM -0500, H. Peter Anvin wrote:
> Yes, a bit sad.  We allow bracketing with the get/put_user_try/catch blocks, but that is x86-specific.
> 
> I don't think a generic option is possible without compiler support, but it might be possible to do better than we do know.

Letting the compiler do it is a bit risky, because it may open it up for
really large blocks, thus defeating the security advantages.

-Andi
