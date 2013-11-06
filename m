From: Michel Lespinasse <walken@google.com>
Subject: Re: [PATCH v3 0/4] MCS Lock: MCS lock code cleanup and optimizations
Date: Wed, 6 Nov 2013 13:59:14 -0800
Message-ID: <CANN689FY67Nu0irKyPxsEPK3NzbpgzKQyW5wLkESfPib9_-zHw@mail.gmail.com>
References: <cover.1383771175.git.tim.c.chen@linux.intel.com>
	<1383773816.11046.352.camel@schen9-DESK>
	<527AB7CA.4020502@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <527AB7CA.4020502@zytor.com>
Sender: owner-linux-mm@kvack.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, "Paul E.McKenney" <paulmck@linux.vnet.ibm.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, Arnd Bergmann <arnd@arndb.de>, Aswin Chandramouleeswaran <aswin@hp.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Nov 6, 2013 at 1:42 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> Perhaps I'm missing something here, but what is MCS lock and what is the
> value?

Its a kind of queued lock where each waiter spins on a a separate
memory word, instead of having them all spin on the lock's memory
word. This helps with scalability when many waiters queue on the same
lock.

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
