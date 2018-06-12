From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH 00/10] Control Flow Enforcement - Part (3)
Date: Tue, 12 Jun 2018 08:03:40 -0700
Message-ID: <1528815820.8271.16.camel@2b52.sc.intel.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
         <bbfde1b3-5e1b-80e3-30e8-fd1e46a2ceb1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bbfde1b3-5e1b-80e3-30e8-fd1e46a2ceb1@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Balbir Singh <bsingharora@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Mike Kravetz <mike.kravetz@oracle.com>
List-Id: linux-arch.vger.kernel.org

On Tue, 2018-06-12 at 20:56 +1000, Balbir Singh wrote:
> 
> On 08/06/18 00:37, Yu-cheng Yu wrote:
> > This series introduces CET - Shadow stack
> > 
> > At the high level, shadow stack is:
> > 
> > 	Allocated from a task's address space with vm_flags VM_SHSTK;
> > 	Its PTEs must be read-only and dirty;
> > 	Fixed sized, but the default size can be changed by sys admin.
> > 
> > For a forked child, the shadow stack is duplicated when the next
> > shadow stack access takes place.
> > 
> > For a pthread child, a new shadow stack is allocated.
> > 
> > The signal handler uses the same shadow stack as the main program.
> > 
> 
> Even with sigaltstack()?
> 
> 
> Balbir Singh.

Yes.
