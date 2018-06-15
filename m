From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH 5/5] Documentation/x86: Add CET description
Date: Fri, 15 Jun 2018 07:22:46 -0700
Message-ID: <1529072566.17958.4.camel@2b52.sc.intel.com>
References: <20180607143544.3477-1-yu-cheng.yu@intel.com>
         <20180607143544.3477-6-yu-cheng.yu@intel.com> <20180615111424.GA4473@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180615111424.GA4473@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Mike Kravetz <mike.kravetz@oracle.com>
List-Id: linux-arch.vger.kernel.org

On Fri, 2018-06-15 at 13:14 +0200, Pavel Machek wrote:
> On Thu 2018-06-07 07:35:44, Yu-cheng Yu wrote:
> > Explain how CET works and the noshstk/noibt kernel parameters.
> > 
> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |   6 +
> >  Documentation/x86/intel_cet.txt                 | 161 ++++++++++++++++++++++++
> 
> Should new files be .rst formatted or something like that?
> 									Pavel

I will fix kernel-parameters.rst.  But currently there is no .rst in
Documentation/x86?

Yu-cheng
