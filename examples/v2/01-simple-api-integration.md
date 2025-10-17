# Example 1: Simple API Integration

**Scenario**: Add weather API integration to display current weather in a web app

**Difficulty**: ⭐ Beginner

**Time**: ~10 minutes

---

## User Request

```
"Add OpenWeather API integration to show current weather on the homepage"
```

---

## Workflow Execution

### Step 1: Research Phase

**User**:
```
@docs-researcher "OpenWeather API for JavaScript"
```

**Output**: ResearchPack with:
- OpenWeather API v2.5 documentation
- API key setup instructions
- `getCurrentWeather(city, apiKey)` API signature
- Error handling patterns
- Rate limits (60 calls/min free tier)

**Validation**: ✅ Hook validates ResearchPack scores 85/100

### Step 2: Planning Phase

**User**:
```
@implementation-planner "Create weather API integration plan"
```

**Output**: Implementation Plan with:
- New files: `src/services/WeatherService.ts` (80 lines)
- Modified files: `src/pages/HomePage.tsx` (add weather widget)
- Config: `.env` (add `OPENWEATHER_API_KEY`)
- Steps: 4 (setup, service, integration, tests)
- Rollback: git revert + env var removal

**Validation**: ✅ Hook validates Plan scores 88/100
✅ API matcher confirms `getCurrentWeather()` matches ResearchPack

### Step 3: Implementation Phase

**User**:
```
@code-implementer "Execute weather API plan"
```

**Execution**:
1. Creates `WeatherService.ts` with error handling
2. Modifies `HomePage.tsx` to display weather
3. Adds `.env.example` with placeholder
4. Creates tests: `WeatherService.test.ts`

**Self-Correction**: Tests fail (missing API key mock)
- Attempt 1: Adds mock for API key → ✅ All tests pass

**Validation**: ✅ All tests passing, build successful

### Step 4: Knowledge Capture

**Automatic** (Stop hook):
- Pattern captured: "External API Service Pattern"
- Documented: Environment variable management
- Recorded: OpenWeather API rate limits

---

## Complete Output Files

### ResearchPack.md

```markdown
# 📋 ResearchPack: OpenWeather API

## Quick Reference
- API: OpenWeather v2.5
- Docs: https://openweathermap.org/current
- Confidence: HIGH

## Key APIs

1. **getCurrentWeather(lat, lon, appid)**
   - Source: openweathermap.org/current#geo
   - Returns: JSON with temp, humidity, conditions
   - Rate limit: 60 calls/min (free)

2. **Error codes**:
   - 401: Invalid API key
   - 429: Rate limit exceeded
   - 404: City not found

## Setup

1. Sign up: openweathermap.org/appid
2. Get API key (free tier)
3. Install: `npm install axios`

## Example

\`\`\`javascript
const response = await axios.get(
  `https://api.openweathermap.org/data/2.5/weather`,
  {
    params: { q: 'London', appid: API_KEY, units: 'metric' }
  }
);
// Returns: { main: { temp: 15.2 }, weather: [{ description: 'clear sky' }] }
\`\`\`

## Checklist
- [ ] Sign up for API key
- [ ] Create WeatherService.ts
- [ ] Add error handling for rate limits
- [ ] Store API key in .env
- [ ] Add loading states in UI
```

### ImplementationPlan.md

```markdown
# 🗺️ Implementation Plan: Weather API Integration

## Summary
Add WeatherService to fetch and display current weather from OpenWeather API.
Store API key securely in environment variables. Display weather widget on homepage.

## 📁 File Changes (4 files)

### New Files (2)
1. `src/services/WeatherService.ts` (~80 lines)
   - Fetches weather from OpenWeather API
   - Handles errors and rate limits
   - Returns typed Weather interface

2. `src/services/WeatherService.test.ts` (~60 lines)
   - Unit tests for happy path and errors

### Modified Files (2)
1. `src/pages/HomePage.tsx`
   - Add WeatherWidget component
   - Call WeatherService.getCurrentWeather()
   - Show loading/error states

2. `.env.example`
   - Add OPENWEATHER_API_KEY=your_key_here

## 🔢 Implementation Steps

**Step 1: Create WeatherService**
- File: `src/services/WeatherService.ts`
- Create class with `getCurrentWeather(city: string)` method
- Use axios to call API
- Handle 401, 429, 404 errors
- Verification: Service exports correctly

**Step 2: Add tests**
- File: `src/services/WeatherService.test.ts`
- Test happy path with mock
- Test error scenarios
- Verification: `npm test` passes

**Step 3: Integrate into HomePage**
- File: `src/pages/HomePage.tsx`
- Import WeatherService
- Add useState for weather data
- Call API on mount
- Display results
- Verification: Page renders without errors

**Step 4: Add environment config**
- File: `.env.example`
- Add API key placeholder
- Verification: Build succeeds

## 🧪 Test Plan
\`\`\`bash
npm test src/services/WeatherService.test.ts
\`\`\`

## ⚠️ Risks
- **Rate limit**: 60/min on free tier → Cache results for 10min
- **API key exposure**: Never commit .env → Add to .gitignore

## 🔄 Rollback
\`\`\`bash
git reset --hard HEAD~1
rm .env
\`\`\`
```

---

## Key Learnings

### What Worked Well
✅ Simple, focused scope
✅ Clear API documentation from research
✅ Plan matched research exactly
✅ Self-correction caught missing test mock
✅ Knowledge automatically captured

### Best Practices Demonstrated
1. **Research first** - No guessing API signatures
2. **Environment variables** - Secure API key storage
3. **Error handling** - Graceful degradation
4. **Testing** - Mock external APIs
5. **Documentation** - Pattern captured for future use

### Common Pitfalls Avoided
❌ Hardcoding API key (used .env)
❌ No error handling (handled 401, 429, 404)
❌ No tests (added comprehensive tests)
❌ No rate limit handling (added 10min cache)

---

## Estimated Time Breakdown

- Research: 2 min
- Planning: 2 min
- Implementation: 5 min (including 1 self-correction)
- Knowledge capture: 1 min (automatic)

**Total**: ~10 minutes

---

## Try It Yourself

1. Start with research:
   ```
   @docs-researcher "OpenWeather API for [your stack]"
   ```

2. Create plan:
   ```
   @implementation-planner "Weather API integration"
   ```

3. Implement:
   ```
   @code-implementer "Execute the plan"
   ```

4. Verify:
   - Check tests pass
   - Verify knowledge-core.md updated
   - Review captured patterns

---

**Next Example**: [02-database-migration.md](./02-database-migration.md) - More complex workflow with rollback scenarios
