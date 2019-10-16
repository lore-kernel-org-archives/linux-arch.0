From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 8/8] x86, kcsan: Enable KCSAN for x86
Date: Wed, 16 Oct 2019 09:14:18 -0700
Message-ID: <ce0d1658-c000-be20-c997-34ca488e4406@intel.com>
References: <20191016083959.186860-1-elver@google.com>
 <20191016083959.186860-9-elver@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191016083959.186860-9-elver@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marco Elver <elver@google.com>
Cc: akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com, parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org, ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com, bp@alien8.de, dja@axtens.net, dlustig@nvidia.com, dave.hansen@linux.intel.com, dhowells@redhat.com, dvyukov@google.com, hpa@zytor.com, mingo@redhat.com, j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net, jpoimboe@redhat.com, luc.maranget@inria.fr, mark.rutland@arm.com, npiggin@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org, tglx@linutronix.de, will@kernel.org, kasan-dev@googlegroups.com, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On 10/16/19 1:39 AM, Marco Elver wrote:
> This patch enables KCSAN for x86, with updates to build rules to not use
> KCSAN for several incompatible compilation units.

First of all KCSAN looks really interesting!

For the x86 code, though, I'd really appreciate some specific notes on
why individual compilation units are incompatible.  There might be some
that were missed, and we have to figure out what we do for any future
work.  Knowing the logic used on these would be really helpful in the
future.
