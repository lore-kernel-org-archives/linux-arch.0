From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH v9 01/27] Documentation/x86: Add CET description
Date: Mon, 9 Mar 2020 16:20:57 -0700
Message-ID: <c06073a2-6858-d5dc-d74b-ef2568bd9423@intel.com>
References: <CAMe9rOoRTVUzNC88Ho2XTTNJCymrd3L=XdB9xFcgxPVwAZ0FWA@mail.gmail.com>
 <AE81FEF5-ECC5-46AA-804D-9D64E656D16E@amacapital.net>
 <CAMe9rOoDMenvD9XRL1szR5yLQEwv9Q6f4O7CtwbdZ-cJqzezKA@mail.gmail.com>
 <0088001c-0b12-a7dc-ff2a-9d5c282fa36b@intel.com>
 <CAMe9rOqf0OHL9397Vikgb=UWhRMf+FmGq-9VAJNmfmzNMMDkCw@mail.gmail.com>
 <56ab33ac-865b-b37e-75f2-a489424566c3@intel.com>
 <CAMe9rOrzrXORQgcAwzGn+=PBvxCEgc5Km_TQq+P7uoqwiacJSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMe9rOrzrXORQgcAwzGn+=PBvxCEgc5Km_TQq+P7uoqwiacJSA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "H.J. Lu" <hjl.tools@gmail.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Yu-cheng Yu <yu-cheng.yu@intel.com>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.ne>
List-Id: linux-arch.vger.kernel.org

On 3/9/20 4:11 PM, H.J. Lu wrote:
> A threaded application is loaded from disk.  The object file on disk is
> either CET enabled or not CET enabled.

Huh.  Are you saying that all instructions executed on userspace on
Linux come off of object files on the disk?  That's an interesting
assertion.  You might want to go take a look at the processes on your
systems.  Here's my browser for example:

# for p in $(ps aux | grep chromium | awk '{print $2}' ); do cat
/proc/$p/maps; done | grep ' r-xp 00000000 00:00 0'
...
202f00082000-202f000bf000 r-xp 00000000 00:00 0
202f000c2000-202f000c3000 r-xp 00000000 00:00 0
202f00102000-202f00103000 r-xp 00000000 00:00 0
202f00142000-202f00143000 r-xp 00000000 00:00 0
202f00182000-202f001bf000 r-xp 00000000 00:00 0

Lots of funny looking memory areas which are anonymous and executable!
Those didn't come off the disk.  Same thing in firefox.  Weird.  Any
idea what those are?

One guess: https://en.wikipedia.org/wiki/Just-in-time_compilation
