From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH 10/10] mm: Prevent munmap and remap_file_pages of shadow
 stack
Date: Thu, 07 Jun 2018 13:15:01 -0700
Message-ID: <1528402501.5265.23.camel@2b52.sc.intel.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
         <20180607143807.3611-11-yu-cheng.yu@intel.com>
         <CALCETrXTyXYCDJxbCA+cbzZirmMKRQq8XSS4+Lyeo_QMywdxFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALCETrXTyXYCDJxbCA+cbzZirmMKRQq8XSS4+Lyeo_QMywdxFw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, mike.kravetz@oracle.com
List-Id: linux-arch.vger.kernel.org

On Thu, 2018-06-07 at 11:50 -0700, Andy Lutomirski wrote:
> On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> 
> blocking remap_file_pages() seems reasonable.  I'm not sure what's
> wrong with munmap().

Yes, maybe we don't need to block munmap().  If the shadow stack is
unmapped, the application gets a fault.  I will remove the patch.
