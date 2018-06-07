From: Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 01/10] x86/cet: User-mode shadow stack support
Date: Thu, 7 Jun 2018 10:55:04 -0700
Message-ID: <67d8a813-b46a-d1da-3897-c38dd5b46b8e@linux.intel.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
 <20180607143807.3611-2-yu-cheng.yu@intel.com>
 <CALCETrX4ALKbphJiZs4MXWtRFvQYD905bNAMTogbOeLh0Pp6xw@mail.gmail.com>
 <1528393611.4636.70.camel@2b52.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528393611.4636.70.camel@2b52.sc.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, Andy Lutomirski <luto@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, mike.kravetz@oracle.com
List-Id: linux-arch.vger.kernel.org

On 06/07/2018 10:46 AM, Yu-cheng Yu wrote:
>> Also, did you add all the needed checks to make get_user_pages(),
>> access_process_vm(), etc fail when called on the shadow stack?  (Or at
>> least fail if they're requesting write access and the FORCE bit isn't
>> set.)
> Currently if FORCE bit is set, these functions can write to shadow
> stack, otherwise write access will fail.  I will test it.

Is this a part of your selftests/ for this feature?
